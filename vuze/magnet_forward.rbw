#!/usr/bin/env ruby

regfile = %Q{
REGEDIT4
[HKEY_CLASSES_ROOT\magnet]
@="URL:magnet protocol"
[HKEY_CLASSES_ROOT\magnet\shell\open\command]
@="c:\\ruby193\\bin\\rubyw.exe c:\\dev\\bittorrent-utils\\vuze\\magnet_forward.rbw \"magnet:%1\""
}

require 'uri'
require 'net/http'
require 'tk'
require 'tidy_ffi'
require 'rexml/document'
include REXML

host = 'leech'
port = 80

uri = URI.parse("http://#{host}:#{port}/vuze/index.tmpl")
params = {
	:d => "u",
	:upurl => ARGV[0],
}

uri.query = URI.encode_www_form params
result = Net::HTTP.get uri

TidyFFI.library_path = '\\bin\\libtidy.dll'
tidy = TidyFFI::Tidy.new result 
tidy.options.output_xhtml = true

doc = Document.new tidy.clean
msg = XPath.first(doc,  "//span[@id='up_msg']").text

root = TkRoot.new {title "Magnet Response"}
TkLabel.new(root) do
  text msg
  pack("padx"=> 15, "pady" => 15, "side" => "left")
end
Tk.mainloop

