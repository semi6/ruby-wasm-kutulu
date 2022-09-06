require 'json'

class Kutulu
  def self.generate
    age = rand(70) + 12
    sex = ['male', 'female'].sample

    str = dice(3, 6) * 5
    con = dice(3, 6) * 5
    siz = (dice(2, 6) + 6) * 5
    dex = dice(3, 6) * 5
    app = dice(3, 6) * 5
    edu = dice(2, 6) * 5
    int = dice(3, 6) * 5
    pow = dice(3, 6) * 5

    mov_down = -> do
      return 5 if age >= 80
      return 4 if age >= 70
      return 3 if age >= 60
      return 2 if age >= 50
      return 1 if age >= 40
      0
    end.call

    mov = -> do
      return 7 if str < siz && dex < siz
      return 9 if str > siz && dex > siz
      8
    end.call - mov_down

    hp = (con + siz).fdiv(10).ceil
    san = pow
    luc = dice(3, 6) * 5
    mp = pow.fdiv(5).ceil

    db, build = -> do
      return ['-2', -2] if siz + str <= 64
      return ['-1', -1] if siz + str <= 84
      return ['0', 0] if siz + str <= 124
      return ['1D4', 1] if siz + str <= 164
      ['1D6', 2]
    end.call

    dodge = dex

    {
      age: age,
      sex: sex,
      str: str,
      con: con,
      siz: siz,
      dex: dex,
      app: app,
      edu: edu,
      int: int,
      pow: pow,
      mov_down: mov_down,
      mov: mov,
      hp: hp,
      san: san,
      luc: luc,
      mp: mp,
      db: db,
      build: build,
      dodge: dodge
    }.to_json
  end

  def self.dice(count, max)
    count.times.sum { rand(max) + 1 }
  end
end
