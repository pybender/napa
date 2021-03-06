module Napa
  class Identity
    def self.health
      {
        name: name,
        hostname: hostname,
        revision: revision,
        pid: pid,
        parent_pid: parent_pid,
        platform: platform
      }
    end

    def self.name
      ENV['SERVICE_NAME'] || 'api-service'
    end

    def self.hostname
      @hostname ||= `hostname`.strip
    end

    def self.revision
      @revision ||= if Napa.heroku?
                      File.exist?('.gitsha') ? File.read('.gitsha').gsub(/[^0-9a-z ]/i, '') : ''
                    else
                      `git rev-parse HEAD`.strip
                    end
    end

    def self.pid
      @pid ||= Process.pid
    end

    def self.parent_pid
      @ppid ||= Process.ppid
    end

    def self.platform
      {
        version: platform_revision,
        name: 'Napa'
      }
    end

    def self.platform_revision
      Napa::VERSION
    end
  end
end
