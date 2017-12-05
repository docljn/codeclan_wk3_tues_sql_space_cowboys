class Bounty
  attr_reader :id
  attr_accessor :name, :bounty_value, :favourite_weapon, :collected_by

  def intitialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @favourite_weapon = options['favourite_weapon']
    @collected_by = options['collected_by']
  end

#save

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

#update

#delete

end
