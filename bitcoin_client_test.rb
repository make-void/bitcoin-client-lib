require 'bundler/setup'
Bundler.require :default

PasswordNotSetError = RuntimeError

def btc_rpc_password(path)
  file = File.read File.expand_path path
  pass = file.match(/rpcpassword=(?<pass>.*)/)[:pass]
  raise PasswordNotSetError unless pass
  pass.strip
end

PASSWORD = btc_rpc_password "~/.bitcoin/bitcoin.conf"

BC = BitcoinClient::Client.new 'bitcoin', PASSWORD

puts BC.balance
