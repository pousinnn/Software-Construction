//spanish
const trans_esp = [
  "Bienvenido a una cafeteria donde vas a poder disfrutar de algo dulce con la compañia de nuestros diferentes gastos. Disfruta de tu tiempo jugando y acarciando a nuestros pequeños amigos. <br> Intenta alejarte de tu apretada agenda y entra a nuestro acogedor santuario, donde nuestros deliciosos postres se encuentran con adorables gatitos. <br>Aqui, tus antojos de la tarde van acompañado de bigotes y nuestras sillas estan listas para ti!",
  "Nuestros gatos son divertidos y adorables! Eres libre de revisar nuestras promociones  especiales y disfruta tu visita. <br> Eres bienvenido a quedarte y divertirte, incluso podrias querer adoptar a un nuevo amigo!",
  "Mira estos videos de nuestro CatCafe: ",
  "Bienvenido a nuestro CatCafe",
  "Inglés",
  "Español",
  "Tagalo"
];

//english
const trans_eng = [
  "Welcome to a coffee shop where you can enjoy a sweet treat with the company of our different cats - enjoy your time playing and petting our little friends! <br> Step away from your busy agenda and enter our cozy sanctuary where our delicious desserts meet adorable cats. <br> Here, your afternoon treat comes with a side of whiskers and our chairs are open for you!",
  "Our cats are really funny and cute! Feel free to check our special promotions and enjoy your visit! <br> You are welcome to stay and have fun, you might even want to adopt a new friend!",
  "Check out these videos from our CatCafe:",
  "Welcome to our CatCafe", 
  "English",
  "Spanish",
  "Tagalog" 
];

//tagalog
const trans_ph = [
  "Maligayang pagdating sa isang coffee shop kung saan maaari kang mag-enjoy ng matatamis na pagkain kasama ang aming iba't ibang pusa sulitin ang iyong oras sa pakikipaglaro at paghaplos sa aming maliliit na kaibigan! <br> Lumayo sandali sa iyong abalang iskedyul at pumasok sa aming maaliwalas na santuwaryo kung saan nagtatagpo ang aming masasarap na panghimagas at ang aming kaibig-ibig na mga pusa. <br> Dito, ang iyong panghapong meryenda ay may kasamang mga bigote, at bukas ang aming mga upuan para sa iyo!",
  "Napaka-kwela at ka-cute ng aming mga pusa! Huwag mag-atubiling tingnan ang aming mga espesyal na promosyon at i-enjoy ang iyong pagbisita. <br> Malugod kang inaanyayahang manatili at magsaya—baka gusto mo pang mag-ampon ng bagong kaibigan!",
  "Panoorin ang mga video mula sa aming",
  "Maligayang pagdating sa aming CatCafe",
  "Ingles",
  "Espanyol",
  "Tagalog"
];

function español() {
  updateText(trans_esp);
}

function english() {
  updateText(trans_eng);
}

function tagalog() {
  updateText(trans_ph);
}

function updateText(languageArray) {
  const title = document.getElementById("title");
  const mainP = document.getElementById("mainP");
  const intro = document.getElementById("intro");
  const videos = document.getElementById("videos");
  const btnEng = document.getElementById("btnEng");
  const btnEsp = document.getElementById("btnEsp");
  const btnTag = document.getElementById("btnTag");

  mainP.innerHTML = languageArray[0];
  intro.innerHTML = languageArray[1];
  videos.innerHTML = languageArray[2];
  title.innerHTML = languageArray[3];
  btnEng.innerHTML = languageArray[4];
  btnEsp.innerHTML = languageArray[5];
  btnTag.innerHTML = languageArray[6];
}

const cats = [
  "https://64.media.tumblr.com/64b6ed1ff5d1b66239c52dcce23ae16c/e3ab46c822214a77-87/s1280x1920/c3b5e1ed0529c2a1969b9ea1ebb888c58025b3ef.pnj",
  "https://64.media.tumblr.com/04a4a0f7d957b053b1c2a996ce784d9c/3d502833b0462564-60/s1280x1920/33d96acb6127925e4b0037d2a7ad12ea84e088d8.pnj",
  "https://64.media.tumblr.com/11b8a6e4e833aea4eec0bbf87184baa6/ff057628208d2a4d-74/s1280x1920/1e70a3fec07af01debb743159c71243c920239df.pnj",
  "https://64.media.tumblr.com/f72be41e239c5fc039c895b30ccd5214/1725af434c156b82-a2/s1280x1920/cddfa8008a2fcb2cb62dc2f639ab3cb91b425fdd.pnj",
  "https://64.media.tumblr.com/9143b74e63849a2ae981b8d2744c9a9d/1725af434c156b82-76/s1280x1920/b83747efe60112a3bc98d4d76cd4ff96f9666679.pnj"
];
let currentCat = 0;
function nextCat() {
  currentCat++;
  if (currentCat >= cats.length) {
    currentCat = 0;
  }
  document.getElementById("ourCats").src = cats[currentCat];
}

const cookies = [
  "https://64.media.tumblr.com/27714e1ec3362940a6f2edc4c4b600ad/8d609bf070049863-64/s1280x1920/0126eebbf2cd88d47c9be472caa6935bae444e22.pnj",
  "https://64.media.tumblr.com/e654aa5e1bd9d5d498d049365cb5f627/8d609bf070049863-d9/s1280x1920/1c07ff99d995f54d8345331cf992b8a0904336ab.pnj",
  "https://64.media.tumblr.com/f31fcf0b9fec256fd09b9595b0ae9e6a/8d609bf070049863-63/s1280x1920/b193828d5f667e51f5dc1cade58a1e24e125e922.pnj",
  "https://64.media.tumblr.com/3af6447cc20a0aee5d5cb159d37b275f/8d609bf070049863-5d/s1280x1920/7e8baeee8d4648061efdaaa36bb7d69ad0044836.pnj",
  "https://64.media.tumblr.com/5ce1031151e8ac2e58908e6e9c0c1e22/8d609bf070049863-5d/s1280x1920/79cd0d7eae9730a2923bb8c0faa35de7a86b5f9a.pnj"
];

let currentCookie = 0;
function nextCookie() {
  currentCookie++;
  if (currentCookie >= cookies.length) {
    currentCookie = 0;
  }
  document.getElementById("galleticas").src = cookies[currentCookie];
}
