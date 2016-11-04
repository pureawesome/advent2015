@boss = {
  hp: 51,
  d: 9
}

@you = {
  hp: 50,
  mana: 500,
  armor: 0,
  shield: 0,
  poison: 0,
  recharge: 0
}

@options = [:missle, :drain, :shield, :poison, :recharge]

# @spells = {
#   missle: { cost: 53, d: 4 },
#   drain: { cost: 73, d: 2, hp: 2 },
#   shield: { cost: 113, armor: 7, duration: 6 },
#   poison: { cost: 173, d: 3, duration: 6 },
#   recharge: { cost: 229, duration: 5, mana: 101 }
# }

@spells = {
  missle: 53,
  drain: 73,
  shield: 113,
  poison: 173,
  recharge: 229
}

def fight
  @player = @you.dup
  @enemy = @boss.dup
  @attack = 'player'
  @history = 0

  turn while @enemy[:hp] > 0 && @player[:hp] > 0 && @player[:mana] > 0
  @scores.push(@history) if @enemy[:hp] <= 0
end

def turn
  if @attack == 'player'
    check_status
    player_attack
    @attack = 'boss'
  else
    check_status
    return if @enemy[:hp] < 1
    @player[:hp] -= (@enemy[:d] - @player[:armor])
    @attack = 'player'
  end
end

def check_status
  if @player[:shield] > 0
    @player[:armor] = 7
    @player[:shield] -= 1
    # p 'shield gives 7 armor and its counter is now' + @player[:shield].to_s
  end

  if @player[:shield] == 0
    @player[:armor] = 0
  end

  if @player[:poison] > 0
    @enemy[:hp] -= 3
    @player[:poison] -= 1
    # p 'poison does 3 and its counter is now' + @player[:poison].to_s
  end

  if @player[:recharge] > 0
    @player[:mana] += 101
    @player[:recharge] -= 1
    # p 'recharge gives 101 mana and its counter is now' + @player[:recharge].to_s
  end
end

def player_attack
  available = @spells.select { |k, v| @player[:mana] >= v}.keys.sample
  # p available
  if available
    spell = 'cast_' + available.to_s
    send(spell.to_sym)
  end
  # player_attacks = @spells.select { |k, v| k if v[:cost] > @player[:mana] }
  # p player_attacks
  # return if @player[:mana] < 53
  # if ((@enemy[:hp] - (3 * @player[:poison])) / 4) < ((@player[:hp] + (7 * @player[:shield])) / @enemy[:d])
  #   cast_missle
  # # elsif (@player[:hp] - @enemy[:d]) &&
  # elsif @player[:poison] <= 0 && ((@player[:mana] >= 402 && @player[:recharge] <= 0) || @player[:mana] >= 173)
  #   cast_poison
  # elsif @player[:recharge] <= 0 && @player[:mana] >= 229 && @player[:mana] < 450 && @enemy[:hp] > 20
  #   cast_recharge
  # elsif @player[:armor] <= 0 && @enemy[:hp] > 30
  #   cast_shield
  # else
  #   cast_missle
  # end
  #
  # attack = rand(0..player_attacks.size)
  # p attack
  # p player_attacks[attack]
  # send(player_attacks[attack])
end

def cast_missle
  # p 'player casts ' + :missle.to_s
  @enemy[:hp] -= 4
  @player[:mana] -= 53
  @history += 53
end

def cast_drain
  # p 'player casts ' + :drain.to_s
  @enemy[:hp] -= 1
  @player[:mana] -= 73
  @player[:hp] += 2
  @history += 73
end

def cast_shield
  # p 'player casts ' + :shield.to_s
  @player[:shield] = 6
  @player[:mana] -= 113
  @history += 113
end

def cast_poison
  # p 'player casts ' + :poison.to_s
  @player[:mana] -= 173
  @player[:poison] = 6
  @history += 173
end

def cast_recharge
  # p 'player casts ' + :recharge.to_s
  @player[:mana] -= 229
  @player[:recharge] = 5
  @history += 229
end


@scores = []
100000.times do |i|
  fight
end
# fight
p @scores.size
p @scores.min if @scores

#1355 too high
#1242 not right
#
#to test 967
#
#
#900
