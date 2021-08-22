// ==UserScript==
// @name        Declutter Jupyterlab for class demos
// @namespace   Violentmonkey Scripts
// @match       http://localhost:8888/doc/tree/*
// @grant       none
// @version     1.0
// @author      -
// @description 21.8.2021, 20:46:05
// ==/UserScript==

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

addGlobalStyle(
  '#jp-top-panel { height: 0px !important; min-height: 0px !important; } ' +
  '.jp-Toolbar { height: 0px !important; min-height: 0px !important; }');
