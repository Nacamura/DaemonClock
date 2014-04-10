require 'clockwork'
load 'TwitDaemon.rb'
load 'tweetbm.rb'
load 'CreditCardHistory.rb'
load 'Radiko.rb'
load 'DropboxUploader.rb'

@twitdaemon

module Clockwork
  handler do |job|
  	job.call
  end

  #TrainSearch jobs
  every(1.minute, (@twitdaemon ||= TwitDaemon.new), :if=>lambda{|t| (16...19) === t.hour})

  #tweetbookmark jobs
  every(1.hour, (TweetBookMark.new), :at=>'**:55')

  #CreditCardHistory jobs
  every(1.day, (CreditCardHistory.new), :if=>lambda{|t| t.day == 25})

  #Radiko jobs
  every(1.day, Radiko.new("INT", "60", "0100", "interfm"), :at=>'00:59')
  every(1.hour, DropboxUploader.new(".mp3"))
end