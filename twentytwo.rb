@boss = {
  hp: 51, d: 9
}

@you = {
  hp: 50, mana: 500, armor: 0, shield: 0, poison: 0, recharge: 0
}

# @spells = {
#   missle: { cost: 53, d: 4 },
#   drain: { cost: 73, d: 2, hp: 2 },
#   shield: { cost: 113, armor: 7, duration: 6 },
#   poison: { cost: 173, d: 3, duration: 6 },
#   recharge: { cost: 229, duration: 5, mana: 101 }
# }

@spells = {
  missle: 53, drain: 73, shield: 113, poison: 173, recharge: 229
}

def fight
  @player = @you.dup
  @enemy = @boss.dup
  @attack = 'player'
  @history = 0

  turn while !gameover?
  @scores.push(@history) if @enemy[:hp] <= 0 && @player[:hp] > 0
end

def gameover?
  @enemy[:hp] <= 0 || @player[:hp] <= 0 || available_spells.empty?
end

def turn
  if @attack == 'player'
    # # part 2
    @player[:hp] -= 1
    return if gameover?

    check_status
    return if gameover?

    player_attack
    @attack = 'boss'
  else
    check_status
    return if gameover?
    @player[:hp] -= [@enemy[:d] - @player[:armor], 1].max
    @attack = 'player'
  end
end

def check_status
  @player[:armor] = 0 if @player[:shield] == 0

  if @player[:shield] > 0
    @player[:armor] = 7
    @player[:shield] -= 1
  end

  if @player[:poison] > 0
    @enemy[:hp] -= 3
    @player[:poison] -= 1
  end

  if @player[:recharge] > 0
    @player[:mana] += 101
    @player[:recharge] -= 1
  end
end

def available_spells
  @spells.select { |_k, v| @player[:mana] >= v }.keys
end

def player_attack
  available = available_spells
  return if available.empty?
  spell = 'cast_' + available.sample.to_s
  send(spell.to_sym)
end

def cast_missle
  @enemy[:hp] -= 4
  @player[:mana] -= 53
  @history += 53
end

def cast_drain
  @enemy[:hp] -= 2
  @player[:mana] -= 73
  @player[:hp] += 2
  @history += 73
end

def cast_shield
  @player[:shield] = 6
  @player[:mana] -= 113
  @history += 113
end

def cast_poison
  @player[:mana] -= 173
  @player[:poison] = 6
  @history += 173
end

def cast_recharge
  @player[:mana] -= 229
  @player[:recharge] = 5
  @history += 229
end

@scores = []
100_000.times do |_i|
  fight
end
p @scores.min
