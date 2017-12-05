# bounty.rb
require('pg')
require('pry-byebug')

class Bounty
  attr_reader :id
  attr_accessor :name, :bounty_value, :favourite_weapon, :collected_by

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @favourite_weapon = options['favourite_weapon']
    @collected_by = options['collected_by']
  end

  def save()
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "
        INSERT INTO bounties (
          name,
          bounty_value,
          favourite_weapon,
          collected_by
        ) VALUES (
          $1, $2, $3, $4
        ) RETURNING *
    ;"
    values = [@name, @bounty_value, @favourite_weapon, @collected_by]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close
  end

  def update()
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "
        UPDATE bounties SET (
            name,
            bounty_value,
            favourite_weapon,
            collected_by
          ) = (
            $1, $2, $3, $4
          ) WHERE id = $5
            ;"
    values = [@name, @bounty_value, @favourite_weapon, @collected_by, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  # Graeme did these on his own.

  # def delete()
  #   db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  #   sql = "DELETE FROM bounties WHERE id = $1;"
  #   values = [@id]
  #   db.prepare("delete_one", sql)
  #   db.exec_prepared("delete_one", values)
  #   db.close()
  # end
  #
  # def self.delete_all()
  #   db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  #   sql = "DELETE FROM bounties;"
  #   db.prepare("delete_all", sql)
  #   db.exec_prepared("delete_all")
  #   db.close()
  # end

  # def find_by_id()
  #   db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  #   sql = "SELECT * FROM bounties WHERE id = $1;"
  #   values = [@id]
  #   db.prepare("find_by_id", sql)
  #   bounty = db.exec_prepared("find_by_id", values)
  #   db.close()
  #   return bounty.map{|bounty| Bounty.new(bounty)}
  # end

  # Implement a `find` method that returns **one** instance of your class (do you have to use a map method? Hmm.)
  # Solo work:
  # Under what circumstances would you be searching for something in a database by id?
  # Would it be less or more efficient to retrieve a selection of records and then iterate through them?

  def delete()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties where id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def self.delete_all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "Delete from bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.find_by(column_name, value)
    # can't do this yet.
    # can't feed in id as a non-string as ruby goes nuts
    # can't feed in 'id' as then my sql string doesn't work
    # can't concatenate as $1 isn't a string at the point that I'm writing the SQL, but if I don't use $1 then I'm not sanitising my data.

    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    # sql = "SELECT * FROM bounties WHERE #{column_name} = #{value} "  -- this works just fine, but no santising
    sql = "SELECT * FROM bounties WHERE $1 = $2"

    values = [column_name, value]
    db.prepare("find", sql)
    bounties = db.exec_prepared("find", values)
    object = bounties.map {|bounty| Bounty.new(bounty)}
    return object
  end

  def self.find_by_id(value)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1"

    values = [value]
    db.prepare("find", sql)
    bounties = db.exec_prepared("find", values)
    object = bounties.map {|bounty| Bounty.new(bounty)}
    binding.pry
    return object
  end



end

# bounty.rb
