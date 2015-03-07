require 'json'
require 'date'

class Exporter

  def initialize(log)
    @log = log
  end

  def export_from(date)
    entries = (@log.from date.to_f).to_a
    write entries, to(file_by date)

    delete entries
  end

  def write(entries, path)
    File.open(path, "w") { |file| 
      file.write JSON entries
    }
  end

  def delete(entries)
    entries.each do |entry|
      @log.delete entry
    end
  end

  def to(file)
    file
  end

  def file_by(date)
    return "./tmp/log-" + Time.now.utc.to_date.to_s + ".json"
  end

end
