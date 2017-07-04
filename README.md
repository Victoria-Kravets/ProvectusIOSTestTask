# ProvectusIOSTestTask

**The given task**:
- Сделать мини iOS приложение(iOS9+) на актуальной версии Swift, используя Carthage dependency manager, которое получает информацию с произвольного сервера в web (на ваше усмотрение), парсит ее(любым образом, все на ваше усмотрение) и на ее основе заполняет экран цветными полосками (как вариант плитками). 
- Вы можете использовать любой путь создания UI и любые библиотеки на ваше усмотрение. Любые вопросы решайте на ваше усмотрение, и любым удобным для вас образом.


**In my solution used next tech stack:** 
- `IOS 10.3`, `Swift 3`, `Alamofire(4.4.0)`, `Quartz 2D`, `Carthage dependency manager`


**Solution description:**
- The app loads an image from any source provided in `URL` textfield, parses it, exctracts colors, proccesses it with the custom alhorithm. And in the end it drawing the same picture using only colorful bars and `Quartz 2D` library. The proccessed image basically looks like mosaic. User is allowed to select the bar size. Also he can try few examples given at the main view, if he doesn't want to search for image url.   

**Instructions:**
- Open `provctusTestTaskByVictoriaKravets.xcworkspace` and run in xcode simulator `makeImageMosaic` project: 
<p align="center">
  <a href="http://gulpjs.com">
    <img src="https://github.com/Victoria-Kravets/ProvectusIOSTestTask/blob/master/screenshots/2.png">
  </a>
  <p align="center">Initial view</p>
</p>

- Provide an image url(like this `http://crosti.ru/patterns/00/03/f5/94338116ed/picture.jpg`) in given textfield and click `Make Mosaic` button, wait till the image get loaded and observe the result. You will have the image recreated with only bars sizeof `20 px`: 

<p align="center">
  <a href="http://gulpjs.com">
    <img src="https://github.com/Victoria-Kravets/ProvectusIOSTestTask/blob/master/screenshots/7.png">
  </a>
  <p align="center">Image recreated with default bars size of 20px</p>
</p>

- Too much fuzzy, huh, lets get back and try a lower bar size, for instance `5 px`:

<p align="center">
  <a href="http://gulpjs.com">
    <img src="https://github.com/Victoria-Kravets/ProvectusIOSTestTask/blob/master/screenshots/5.png">
  </a>
  <p align="center">Image recreated with default bars size of 5px</p>
</p>

- Looks better, right? Let compare it to original one in `*.jpg` format:

<p align="center">
  <a href="http://gulpjs.com">
    <img src="https://github.com/Victoria-Kravets/ProvectusIOSTestTask/blob/master/screenshots/6.png">
  </a>
  <p align="center">Original image http://crosti.ru/patterns/00/03/f5/94338116ed/picture.jpg</p>
</p>

- Also be aware to provide a valid url, if not you will get warning message! =) Don't be shy to try a few examples at the main view, they may come very handy if you don't wanna search for image url.

<p align="center">
  <a href="http://gulpjs.com">
    <img src="https://github.com/Victoria-Kravets/ProvectusIOSTestTask/blob/master/screenshots/9.png">
  </a>
  <p align="center">Warning alert in case user provide invalid url</p>
</p>
