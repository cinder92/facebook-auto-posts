import 'dart:io';

import 'package:facebook_auto_posts/database/models/logger.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:facebook_auto_posts/types/loggerTypes.dart';
import 'package:puppeteer/puppeteer.dart';

LoggerModel logger = LoggerModel();

var browser;

String facebookLoginBtn = '._6ltg'; // id facebook btn
String facebookInputFile = 'input[type=file]';
String facebookPostBtn = 'div[aria-label="Post"]';
String facebookInputEmail = 'input[name=login_source]';
String facebookInputPassword = 'input[name=pass]';
String facebookUserPostBox = '.x78zum5.x1n2onr6.xh8yej3';
String facebookJoinGroupBtn = '[aria-label="Join group"]';
String facebookGroupPostBox =
    '.xi81zsa.x1lkfr7t.xkjl1po.x1mzt3pk.xh8yej3.x13faqbe';

void stopBrowser() async {
  if (browser != null) {
    browser.process.kill;
    await browser.close();
  }
}

Future<String> login({required Accounts acc, required dynamic page}) async {
  await page.waitForSelector(facebookLoginBtn);

  final email = await page.waitForSelector(facebookInputEmail);
  final password = await page.waitForSelector(facebookInputPassword);
  final submitButton = await page.waitForSelector(facebookLoginBtn);

  await email.type(acc.email, delay: const Duration(milliseconds: 100));
  await password.type(acc.password, delay: const Duration(milliseconds: 100));

  await submitButton!.click();

  await page.waitForNavigation(wait: Until.networkIdle);

  // TODO: check for the browser link and if it shown unavailable then redirect user to the team link

  final hasAccess = await page.$OrNull(facebookUserPostBox);
  return hasAccess == null ? "LOGIN_ERROR" : "";
}

List<Groups> postedInGroups = [];
Future<void> makePosts({
  required List<Groups> groups,
  required Posts post,
  required dynamic page,
}) async {
  if (groups.isEmpty) {
    await logger.addLog('Publicaciones terminadas.', LoggType.SUCCESS);
    stopBrowser();
    return;
  }

  final postResult = await postInGroup(
    group: groups.first,
    post: post,
    page: page,
  );

  if (postResult.isNotEmpty) {
    groups.removeWhere((group) => group.id == groups.first.id);
    postedInGroups = groups;
    await makePosts(groups: postedInGroups, post: post, page: page);
  }
}

Future<String> postInGroup({
  required Posts post,
  required Groups group,
  required dynamic page,
}) async {
  await logger.addLog(
    'Navegando a : ${group.name}',
    LoggType.CONSOLE,
  );

  await page.goto(group.url, wait: Until.networkIdle);

  final hasAccess = await page.$OrNull(facebookJoinGroupBtn);

  if (hasAccess != null) {
    await logger.addLog(
      'La cuenta no tiene acceso al grupo ${group.name}',
      LoggType.WARNING,
    );
    // request access maybe and navigate to next group? if no next group, close the browser
    // TODO: Request group access
    return "NO_ACCESS";
  }

  final hasPostbox = await page.$OrNull(facebookGroupPostBox);
  if (hasPostbox == null) {
    await logger.addLog(
      'La cuenta no puede comentar en ${group.name}',
      LoggType.WARNING,
    );
    return "CANT_COMMENT";
  }

  // open comment box
  await hasPostbox.click();

  // upload files
  if (post.files!.isNotEmpty) {
    // grab path and conver to File
    List<String>? filePaths = post.files?.split(';');

    List<File> files = [];

    filePaths!.forEach((file) {
      files.add(File(file));
    });

    final element = await page.$OrNull(facebookInputFile);

    await element.uploadFile(files);

    await page.waitForSelector(
      '.x78zum5.xl56j7k',
      timeout: const Duration(seconds: 5),
    );

    await page.waitForSelector(
      '.notranslate._5rpu',
      timeout: const Duration(seconds: 5),
    );

    final postNow = await page.waitForSelector(
      'div[aria-label="Post"].x1i10hfl.xjbqb8w.x6umtig.x1b1mbwd.xaqea5y.xav7gou.x1ypdohk.xe8uvvx.xdj266r.x11i5rnm.xat24cr.x1mh8g0r.xexx8yu.x4uap5.x18d9i69.xkhd6sd.x16tdsg8.x1hl2dhg.xggy1nq.x1o1ewxj.x3x9cwd.x1e5q0jg.x13rtm0m.x87ps6o.x1lku1pv.x1a2a7pz.x9f619.x3nfvp2.xdt5ytf.xl56j7k.x1n2onr6.xh8yej3',
      timeout: const Duration(seconds: 5),
    );

    final wrapper = await page.$OrNull('.x78zum5.xl56j7k');
    if (wrapper != null) {
      final content = await page.$OrNull('.notranslate._5rpu');
      if (content != null) {
        final strList = post.content.split('');
        await Future.forEach(strList, (letter) async {
          await page.keyboard.type(
            letter,
            delay: const Duration(milliseconds: 100),
          );
        });

        // click on post

        await postNow.click();
        await Future.delayed(const Duration(seconds: 5), () {});

        await logger.addLog(
          'Publicación con archivos completa en el grupo ${group.name}',
          LoggType.CONSOLE,
        );
        return "CONTINUE";
      } else {
        await logger.addLog(
          'Contenido no disponible',
          LoggType.ERROR,
        );
        return "CANT_COMMENT";
      }
    }
  } else {
    // no files for post, write directly
    await hasPostbox.type(
      post.content,
      delay: const Duration(milliseconds: 100),
    );

    // click on post
    final postNow = await page.waitForSelector(facebookPostBtn);
    await postNow.click();
    await Future.delayed(const Duration(seconds: 5), () {});
    await logger.addLog(
      'Publicación completa en el grupo ${group.name}',
      LoggType.CONSOLE,
    );
    return "CONTINUE";
  }

  return "";
}

void initScrapping(
  Accounts acc,
  Posts post,
  List<Groups> groups,
) async {
  await logger.clear();
  // first facebook page is login page
  const website = 'https://www.facebook.com/';

  if (acc.id == 0) {
    logger.addLog('No se seleccionó una cuenta', LoggType.ERROR);
    return;
  }

  if (post.id == 0) {
    logger.addLog('No se seleccionó una publicación.', LoggType.ERROR);
    return;
  }

  if (groups.isEmpty) {
    logger.addLog('No se seleccionaron los grupos', LoggType.ERROR);
    return;
  }

  try {
    // TODO: Allow "debug" mode in settings page
    // const showBrowser = isDebug
    // TODO: Check when local-chromium has been downloaded, so we can ride out of this log
    await logger.addLog('Iniciando navegador ...', LoggType.CONSOLE);
    browser = await puppeteer.launch(
      headless: false,
      noSandboxFlag: true,
      args: ['--disable-setuid-sandbox'],
    );

    final context = await browser.createIncognitoBrowserContext();
    //open new tab
    final page = await context.newPage();

    //set useragent
    // TODO: Allow user to set any user agent from a settings page
    await page.setUserAgent(
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.61/63 Safari/537.36',
    );

    //visit from desktop browser
    await page.setViewport(
      const DeviceViewport(width: 1280, height: 1024),
    );

    await page.setCacheEnabled(false);
    await logger.addLog('Navegando a $website', LoggType.SUCCESS);
    await page.goto(website, wait: Until.networkIdle);

    final loginResult = await login(acc: acc, page: page);
    if (loginResult.isNotEmpty) {
      await logger.addLog('La sesión no se pudo iniciar.', LoggType.ERROR);
      return;
    }

    await logger.addLog('Sesión iniciada correctamente.', LoggType.SUCCESS);
    // post in groups here ...
    Future.delayed(const Duration(seconds: 3), () async {
      await makePosts(groups: groups, post: post, page: page);
    });
  } catch (error, _) {
    if (error.toString().contains('TargetClosedException')) {
      await logger.addLog('Programa terminado manualmente.', LoggType.WARNING);
    } else {
      await logger.addLog(
        'Ha ocurrido un error : ${error.toString()}',
        LoggType.ERROR,
      );
    }
  }
}
