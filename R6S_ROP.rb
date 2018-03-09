require 'discordrb'
require "csv"

bot = Discordrb::Commands::CommandBot.new token: 'NDIxMTcwNjQ0Mjk0ODI4MDM1.DYJVRA.6Y9xVX-7xfUwhh9HRXLNpax4bGc',
client_id: 421170644294828035,
prefix:'!'



#!solo 入力した人のみ
bot.command :solo do |event,*code|
        filename = "OPFILE/" + event.user.name + "_" + code[0] + ".csv"
        data = CSV.read(filename)
        
        #dataにオペレータがいない場合新兵の追加
        if data.length == 0
            event.respond "#{users[num].name}の選択出来るオペレータがいません。新兵を追加します"
            data.push(["Recruit"])
        end
    
        number = 0
        a = 0
        a = data.length
        a = a - 1
        
        number = rand(0..a)
    
        event.respond "#{event.user.name} の使うオペレーター -> #{data[number][0]}"

end

#"!random ボイスチャンネルにいる全員"
bot.command :random do |event,*code|
    
    channel = event.user.voice_channel
    users = channel.users

    operaters = Array.new()
    
    number = 0
    

    for num in 0..users.length do

        filename = "OPFILE/" + users[num].name + "_" + code[0] + ".csv"
        data = CSV.read(filename)

        #使用したオペレーターをdataから削除
        data.delete_if do |str|
            operaters.include?(str)
        end
        
        #dataにオペレータがいない場合新兵の追加
        if data.length == 0
            event.respond "#{users[num].name}の選択出来るオペレータがいません。新兵を追加します"
            data.push(["Recruit"])
        end

        number = 0
        a = 0
        a = data.length
        a = a - 1
        
        number = rand(0..a)

        #使用オペレータにdataを追加
        operaters.push([data[number][0]])

        #data表示
        #a = 0
        #data.length.times{
        #    event.respond data[a][0]
        #    a += 1
        #}
        event.respond "#{users[num].name} の使うオペレーター -> #{data[number][0]}"

#テスト用コメントアウト
=begin
        #dataから使用したオペレータの削除(テスト用)    
        data.delete_if do |str|
            operaters.include?(str)
        end
 
        #削除後のdata表示(テスト用)
        a=0
        
        data.length.times{
            event.respond data[a][0]
            a += 1
        }
=end

    end
end


bot.run
