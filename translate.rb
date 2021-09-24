require 'rest-client'
require 'json'

class Translate

    @@url = 'https://translation.googleapis.com/language/translate/v2?'
    @@key = 'put a google translate key here'

    def initialize
        puts 'Write the text you want translate:'
        @text = gets
        #for more languages, use https://cloud.google.com/translate/docs/languages?hl=pt_BR
        puts 'In which language do you want the translation? [pt,ja,en,es,ru,...]'
        @to = gets.chomp
        @path = "#{@@url}key=#{@@key}&q=#{@text}&target=#{@to}" 
        construe
    end

    private 

    def construe 
        resp = RestClient.get(@path)
        json_treatment(resp)
        write 
    end

    def write
        day = Time.now.strftime('%m-%d-%Y-%H:%M')
        File.open("#{day}.txt", 'w') do |line|
            line.puts('Text: '+ @text)
            line.puts('Initial Language is '+ @from)
            line.puts("Translated to #{@to}.")
            line.print("Text translated: "+ @initial_text)
        end
    end

    def json_treatment(resp)
        json = JSON.parse(resp)
        @initial_text = json["data"]["translations"][0]["translatedText"]
        @from = json["data"]["translations"][0]["detectedSourceLanguage"]
    end
end

Translate.new
