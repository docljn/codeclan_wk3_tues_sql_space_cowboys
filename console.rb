require ("pry-byebug")
require_relative("./model/bounty.rb")

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

  bounty1.save()
  bounty2.save()


  binding.pry
  nil
  