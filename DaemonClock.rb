require 'clockwork'
load './TrainSearch/TwitDaemon.rb'
load './tweetbookmark/tweetbm.rb'
load './CreditCardHistory/CreditCardHistory.rb'

@twitdaemon
@tweetbm

module Clockwork
  handler do |job|
  	job.call
  end

  #TrainSearch jobs
  every(1.minute, (@twitdaemon ||= TwitDaemon.new), :if=>lambda{|t| (16...19) === t.hour})

  #tweetbookmark jobs
  every(1.hour, (@tweetbm ||= TweetBookMark.new), :at=>'**:55')

  #CreditCardHistory jobs
  every(1.day, (CreditCardHistory.new), :if=>lambda{|t| t.day == 25})
end