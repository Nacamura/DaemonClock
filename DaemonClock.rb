require 'clockwork'
load './TrainSearch/TwitDaemon.rb'
load './tweetbookmark/tweetbm.rb'

@twitdaemon
@tweetbm

module Clockwork
  handler do |job|
  	job.call
  end

  #TrainSearch jobs
  every(1.minute, (@twitdaemon ||= TwitDaemon.new))
  every(1.day, lambda {@twitdaemon.enable}, :at=>'16:00')
  every(1.day, lambda {@twitdaemon.disable}, :at=>'19:00')

  #tweetbookmark jobs
  every(1.hour, (@tweetbm ||= TweetBookMark.new), :at=>'**:55')
end