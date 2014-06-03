About
-----

SPVoice was born out of my need for a generic API for voice commands.  You can use it directly as a Ruby object or as an HTTP based JSON API.  SPVoice uses lightly modified SiriProxy plugins, and is, itself, heavily modified SiriProxy code. Using (Siri-API)[/Hackworth/Siri-API] you can run SPVoice plugins using Siri, for example, opening Siri and saying <code>Yahoo watch game of thrones season 4 episode 3</code>

Set-up Instructions
-------------------

Install RVM with Ruby:

    curl -sSL https://get.rvm.io | bash -s stable --ruby

Install SPVoice:

    mkdir ~/voice-API && cd ~/voice-API
    git clone https://github.com/Hackworth/SPVoice.git 
    cd SPVoice
    gem build spvoice.gemspec 
    gem install spvoice-*.gem
    mkdir ~/.spvoice
    cp ./config.example.yml ~/.spvoice/config.yml

Edit <code>~/.spvoice/config.yml</code> to add the plugins you want to use.

Usage
-----

To use SPVoice from Ruby:

    require 'spvoice'
    spvoice = SPVoice.new
    puts spvoice.run("Turn on kitchen")

To use SPVoice as a HTTP JSON API:

    curl -d '{"command": "turn on hallway"}' 'http://localhost:9000/command' -H Content-Type:application/json

    {"response":"Turning on Hallway"}%

Please note the HTTP JSON API currently has no authentication, so please don't expose port 9000 to the internet.

Plugins
-------
(XBMC)[/Hackworth/SPVoice-XBMC]
(MiOS)[/Hackworth/SPVoice-MiOS]

License (MIT)
-------------

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
