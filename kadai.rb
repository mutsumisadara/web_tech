require 'webrick' # webrick呼出Rubyファイル内で使えるようにしている。

server = WEBrick::HTTPServer.new({ #webrickのインスタンス作成server変数に代入。
  :DocumentRoot => '.', # Webアプリケーションのドメインの設定
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  # プログラムを実行（翻訳）できるプログラム（Rubyのこと）本体の居場所を指定する記述。
  :Port => '3000', #Webアプリケーションの情報の出入り口を表す設定。
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'kadai.html.erb')
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'kadai.html.erb')
server.mount('/givefor_cgi.cgi', WEBrick::HTTPServlet::CGIHandler, 'givefor_cgi.rb')
server.mount('/quality_cgi.cgi', WEBrick::HTTPServlet::CGIHandler, 'quality_cgi.rb')

server.start # webrickのサーバー起動