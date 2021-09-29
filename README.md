<a href="http://GoQuick.org/"><b>GoQuick</b></a>は
ブックマークしたページに簡単にアクセスしたり
ブックマークを簡単に登録したりするシステムです。

<ul>
  <li><a href="https://bitly.com/">Bit.ly</a>
    や
    <a href="https://goo.gl/">Goo.gl</a>
    のようなURL短縮サービスと同じように、
    短いURLで様々なWebページにアクセスすることができます
  </li>
  <li>たとえば<code>map</code>のような名前でGoogle地図のURLを登録しておくと
    <a href="http://GoQuick.org/map"><code>http://GoQuick.org/map</code></a>
    のようなURLでGoogle地図にアクセスできます
  </li>
  <li>
    GoQuickをChromeの標準検索として指定しておくと、
    URL枠(Omnibox)で<code>map</code>などと入力して登録URLに飛ぶことができます
    <br>
    <img src="https://gyazo.com/23949b2b951229a31c2b209d1579a6e4.png">
  </li>
  <li>
    登録されていない単語をURL入力枠に入力したときはGoogle検索が実行されます
  </li>
  <li>
    登録ブックマークレット:
    <code>
      javascript:(function(){var%20w=window.open();var%20desc=window.getSelection();if(desc=='')desc=document.title;var%20url=document.location.href;w.location.href='http://GoQuick.org/_edit?longname='+escape(url)+'&description='+encodeURIComponent(desc);})()</code>
  </li>
  <li>詳細は<a href="https://scrapbox.io/GoQuick">こちら</a></li>
</ul>

<!-- Heroku-18 stack に変更 -->
