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


# define some console helpers

def reload
  load File.expand_path __FILE__
end

def balance
  BC.balance
end

def address
  BC.getnewaddress
end

def address_balance(addr)
  BC.balance addr
end

def keypair
  BC.get
end

def private_key
  BC.dumpprivkey
end

def send_btc
  # BC....
end

alias :transfer :send_btc

def info
  puts BC.help
  puts
  puts "finished printing `bitcoin-cli help`-like command sent via json"
  true
end
