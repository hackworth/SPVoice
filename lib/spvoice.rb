require 'optparse'
require 'yaml'
require 'ostruct'

class SPVoice
  $LOG_LEVEL = 0

  def initialize
    @branch = nil
    parse_options
    command     = ARGV.shift
    subcommand  = ARGV.shift
    load_code
    init_plugins
    @cora = SPVoice::PluginManager.new
    case command
    when 'server'           then run_server(subcommand)
    when 'bundle'           then run_bundle(subcommand)
    when 'console'          then run_console
    when 'update'           then update(subcommand)
    when 'help'             then usage
    end
  end

  def run(input)
    @cora.process(input)
    return @cora.response
  end

  def run_console
    repl = -> prompt { print prompt; @cora.process(gets.chomp!) }
    loop { repl[">> "] }
  end

  def run_bundle(subcommand='')
    setup_bundler_path
    puts `bundle #{subcommand} #{ARGV.join(' ')}`
  end

  def run_server(subcommand='start')
    load_code
    init_plugins
    start_server
  end

  def start_server
  end

  def update(directory=nil)
    if(directory)
      puts "=== Installing from '#{directory}' ==="
      puts `cd #{directory} && rake install`
      puts "=== Bundling ===" if $?.exitstatus == 0
      puts `spvoice bundle` if $?.exitstatus == 0
      puts "=== SUCCESS ===" if $?.exitstatus == 0
      
      exit $?.exitstatus
    else
      branch_opt = @branch ? "-b #{@branch}" : ""
      @branch = "master" if @branch == nil
      puts "=== Installing latest code from git://github.com/Hackworth/SPVoice.git [#{@branch}] ==="

	  tmp_dir = "/tmp/SPVoice.install." + (rand 9999).to_s.rjust(4, "0")

	  `mkdir -p #{tmp_dir}`
      puts `git clone #{branch_opt} git://github.com/Hackworth/SPVoice.git #{tmp_dir}`  if $?.exitstatus == 0
      puts "=== Performing Rake Install ===" if $?.exitstatus == 0
      puts `cd #{tmp_dir} && rake install`  if $?.exitstatus == 0
      puts "=== Bundling ===" if $?.exitstatus == 0
      puts `spvoice bundle`  if $?.exitstatus == 0
      puts "=== Cleaning Up ===" and puts `rm -rf #{tmp_dir}` if $?.exitstatus == 0
      puts "=== SUCCESS ===" if $?.exitstatus == 0

      exit $?.exitstatus
    end 
  end

  def usage
    puts "\n#{@option_parser}\n"
  end

  private
  
  def parse_options
    config_file = File.expand_path(File.join('~', '.spvoice', 'config.yml'));

    unless File.exists?(config_file)
      default_config = config_file
      config_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'config.example.yml'))
    end

    $APP_CONFIG = OpenStruct.new(YAML.load_file(config_file))

    # Google Public DNS servers
    #$APP_CONFIG.upstream_dns ||= %w[8.8.8.8 8.8.4.4]

    @branch = nil
    @option_parser = OptionParser.new do |opts|
      opts.on('-l', '--log LOG_LEVEL',   '[server]      The level of debug information displayed (higher is more)') do |log_level|
        $APP_CONFIG.log_level = log_level
      end
      opts.on('-p', '--port PORT',       '[server]      Port number for server (central or node)') do |port_num|
        $APP_CONFIG.port = port_num
      end
      opts.on('-b', '--branch BRANCH',   '[update]      Choose the branch to update from (default: master)') do |branch|
        @branch = branch
      end
      opts.on_tail('-v', '--version',  '              Show version') do
        require "spvoice/version"
        puts "SPVoice version #{SPVoice::VERSION}"
        exit
      end
    end
    #@option_parser.banner = BANNER
    @option_parser.parse!(ARGV)
  end

  def setup_bundler_path
    require 'pathname'
    ENV['BUNDLE_GEMFILE'] ||= File.expand_path("../../Gemfile",
      Pathname.new(__FILE__).realpath)
  end

  def load_code
    setup_bundler_path

    require 'bundler'
    require 'bundler/setup'
    require 'spvoice/plugin'
    require 'spvoice/plugin_manager'
  end
  
  def init_plugins
    pManager = SPVoice::PluginManager.new
    pManager.plugins.each_with_index do |plugin, i|
      if plugin.respond_to?('plugin_init')                                                                     
        $APP_CONFIG.plugins[i]['init'] = plugin.plugin_init
      end
    end
    pManager = nil
  end
end
