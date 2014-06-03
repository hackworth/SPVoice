About
-----
SPVoice was born out of my need for a generic API for voice commands.  You can use it directly as a Ruby object or as an HTTP based JSON API.  SPVoice uses lightly modified SiriProxy plugins, and is, itself, heavily modified SiriProxy code.  

Set-up Instructions
-------------------

Install RVM with Ruby:

    curl -sSL https://get.rvm.io | bash -s stable --ruby

Install SPVoice:

    mkdir ~/voice-API && cd ~/voice-API
    git clone https://github.com/Hackworth/SPVoice.git 
    cd SPVoice
    gem build 

**NEW Instructions for 0.5.0**

Note that the installation instructions have changed. It's no longer necessary to install dnsmasq. Also, SiriProxy is available via rubygems for easy installation.

**Set up RVM and Ruby 2.0.0**

If you don't already have Ruby 2.0.0 (or at least 1.9.3) installed through RVM, please do so in order to make sure you can follow the steps later. Experts can ignore this. If you're unsure, follow these directions carefully:

1. Install pre-requisites. Veries by system. For a fresh Ubuntu 12.10 install, these seem to be good:

	`sudo apt-get install libxslt1.1 libxslt-dev xvfb build-essential git-core curl libyaml-dev libssl-dev`

2. Download and install RVM (if you don't have it already):
	* Download/install RVM:  
		`curl -L https://get.rvm.io | bash -s stable --ruby`  
	* Update .bashrc:  
		`echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc`
		`echo 'export PATH=$HOME/.rvm/bin:$PATH' >> ~/.bashrc`  
	* Activate changes:  
		`. ~/.bashrc`   

3. Install Ruby 2.0.0 (if you don't have it already):   

	`rvm install 2.0.0`  

4. Set RVM to use/default to 2.0.0:   

	`rvm use 2.0.0 --default`
	
**Set up SiriProxy**

1. Install SiriProxy Gem
 
	`gem install siriproxy`

2. Create `~/.siriproxy` directory

	`mkdir ~/.siriproxy`

3. Generate Certificates

	`siriproxy gencerts`

4. Transfer certificate to your phone (it will be located at `~/.siriproxy/ca.pem`, email it to your phone)
5. Start SiriProxy (`XXX.XXX.XXX.XXX` should be replaced with your server's IP address, e.g. `192.168.1.100`), `nobody` can be replaced with any un-privileged user.

	`rvmsudo siriproxy server -d XXX.XXX.XXX.XXX -u nobody`

6. Tell your phone to use your SiriProxy server as its DNS server (under your Wifi settings)
7. Test that the server is running by saying "Test Siri Proxy" to your phone.

License (MIT)
-------------

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
