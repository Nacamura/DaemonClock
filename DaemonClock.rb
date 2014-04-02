require 'clockwork'
load 'TwitDaemon.rb'
load 'tweetbm.rb'
load 'CreditCardHistory.rb'

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
end