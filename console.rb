# console.rb
require ("pry-byebug")
require_relative("./model/bounty.rb")

Bounty.delete_all()

bounty1 = Bounty.new({
  'name' => 'Red',
  'bounty_value' => '250',
  'favourite_weapon' => 'ray gun',
  'collected_by' => 'Dread Pirate Roberts'
  })

bounty2 = Bounty.new({
  'name' => 'Purple',
  'bounty_value' => '150',
  'favourite_weapon' => 'phazer',
  'collected_by' => 'Princess Leia'
  })

bounty3 = Bounty.new({
  'name' => 'Gold',
  'bounty_value' => '100',
  'favourite_weapon' => 'Xenon Whip'
  })

bounty1.save()
bounty2.save()
bounty3.save()

bounty1.name='Blue'
bounty1.update()

bounty1.delete()
# found = bounty1.find_by_id()

found = Bounty.find_by('id', 2)

found_by_id = Bounty.find_by_id(3)

binding.pry
nil

# console.rb
