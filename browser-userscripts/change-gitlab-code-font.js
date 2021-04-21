// ==UserScript==
// @name        Gitlab font changer
// @namespace   local.greasemonkey.gitlabfontchanger
// @include     https://gitlab.tiker.net.com/*
// @include     https://gitlab.com/*
// @version     3
// ==/UserScript==

// https://stackoverflow.com/questions/7372428/changing-the-default-github-code-font

var fontdef = "Iosevka !important";

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
  '.diff-table.code { font-family: ' + fontdef + '; } ' +
  '.diff-td { font-size: 100% !important; } ' +
  '');
