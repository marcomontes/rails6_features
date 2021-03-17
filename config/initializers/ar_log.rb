class ActiveRecord::ConnectionAdapters::AbstractAdapter
  alias :original_log :log
  def log(sql, name = "SQL", binds = [], statement_name = nil)
    connection_name = respond_to?(:log_name) ? log_name : nil
    name = [connection_name, name].compact.join(" ")
    original_log(sql, name, binds, statement_name) { yield }
  end
end
