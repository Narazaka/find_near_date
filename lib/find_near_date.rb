require "find_near_date/version"

module FindNearDate
  # find record by date from DB tables that is not indexed by date column
  # @param [Time] date date to find
  # @param [Symbol] date_column date column name
  # @param [Symbol] key_column primary_key column
  # @param [Number] period acceptable defference period. if this is 0, find most near date
  # @param [Boolean] log print log or not
  def find_near_date(date, date_column = :created_at, key_column: primary_key, period: 0, log: false)
    _first = select(key_column, date_column).order(key_column => :asc).first
    _last = select(key_column, date_column).order(key_column => :desc).first
    find_near_date_iteration(_first, _last, _last, date, date_column, key_column, period, log)
  end

  def find_near_date_iteration(_first, _last, _previous, date, date_column, key_column, period, log) # rubocop:disable Metrics/AbcSize, Metrics/ParameterLists, Metrics/LineLength
    start_key = _first.public_send(key_column)
    end_key = _last.public_send(key_column)
    key_period = end_key - start_key
    start_date = _first.public_send(date_column)
    end_date = _last.public_send(date_column)
    date_period = end_date - start_date
    rate = 1.0 * (date - start_date) / date_period
    target_key = (key_period * rate).round + start_key
    _next = where("#{key_column} >= ?", target_key).order(key_column => :asc).first # id may not be exists
    return _next if _next.public_send(key_column) == _previous.public_send(key_column)

    next_date = _next.public_send(date_column)
    date_diff = next_date - date
    return _next if date_diff == 0 || date_diff.abs <= period

    if date_diff > 0
      _last = _next
    else
      _first = _next
    end
    puts "find_date_id> diff=#{date_diff} target=#{date} current #{key_column}=#{target_key} [#{start_key}=#{start_date} - #{end_key}=#{end_date}]" if log
    find_near_date_iteration(_first, _last, _next, date, date_column, key_column, period, log)
  end
end
