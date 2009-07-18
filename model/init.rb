require 'dm-core'
require 'dm-validations'
require 'dm-aggregates' # needed for #count in spec
db_path = RubyStation.data_path('ticketmap.db')
DataMapper.setup(:default, "sqlite3://#{db_path}")

require __DIR__('./ticket.rb')

DataMapper.auto_upgrade!

# 
# ramaze paginate for datamapper
#
require 'ramaze/helper/paginate'
class DataMapper::Collection
  def paginate(page, limit)
    DMCollectionPager.new(self, page, limit)
  end

  class DMCollectionPager < Ramaze::Helper::Paginate::Paginator::ArrayPager
    def each(&block)
      from = ((@page - 1) * @limit)
      from = 0 if from < 0
      to = from + @limit

      a = @array[from...to] || []
      a.each(&block)
    end

  end
end

