require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable

  def where(params)
    conditions = params.map do |key, value|
      "#{key} = ?"
    end.join(" AND ")
    result = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{conditions};
    SQL

    self.parse_all(result)
  end

end

class SQLObject
  extend Searchable
end
