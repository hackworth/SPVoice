require 'grape'
require 'json'
require 'rack'
require 'spvoice'

module Server
  module Config
    @@spv = SPVoice.new
    def spvrun(command)
      @@spv.run(command)
    end
  end

  class API < Grape::API
    default_format :json
    format :json
    helpers Config

    resource :command do
      desc "Do a Command"
      params do
        requires :command, type: String, desc: "Command."
      end
      post do
        Hash["response", spvrun(params[:command]).gsub("\n", "\\n")]
      end
    end
  end
end

Rack::Handler::WEBrick.run(Server::API, :Port => 9000)
