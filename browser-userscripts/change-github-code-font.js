// ==UserScript==
// @name        Github font changer
// @namespace   local.greasemonkey.githubfontchanger
// @include     https://github.com/*
// @version     3
// ==/UserScript==

// https://stackoverflow.com/questions/7372428/changing-the-default-github-code-font

var fontdef = "Iosevka";

function addGlobalStyle(css)
{
    var head, style;
    head = document.getElementsByTagName('head')[0];
    if (!head) { return; }
    style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = css;
    head.appendChild(style);
}

// Apply the font-family definition to code styles.
addGlobalStyle(
  '.blob-code-inner { font-family: ' + fontdef + ' !important; font-size: 100% !important; } ' +
  '.file-info { font-family: ' + fontdef + '; font-size: 100% !important; } ' +
  '');
