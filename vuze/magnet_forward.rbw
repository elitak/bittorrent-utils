#!/usr/bin/env ruby

#NOTES
# gem install ruby_ffi
# put libtidy.dll in the right spot, change path in here
# make sure the vuze "HTML Web UI" is running somewhere
# change host+port appropriately in here
# finally, something like this goes into your registry:
regfile = %Q{
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\magnet]
@="URL:magnet protocol"

[HKEY_CLASSES_ROOT\magnet\shell]

[HKEY_CLASSES_ROOT\magnet\shell\open]

[HKEY_CLASSES_ROOT\magnet\shell\open\command]
@="\"c:\\ruby193\\bin\\rubyw.exe\" \"c:\\dev\\bittorrent-utils\\magnet_forward.rbw\" \"magnet:%1\""
}
# now just click a magnet link!

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


# TODO: add buttons 1 and 2 to select different vuze clients

root = TkRoot.new {title "Magnet Response"}
TkLabel.new(root) do
  text msg
  pack("padx"=> 15, "pady" => 15, "side" => "left")
end
Tk.mainloop

