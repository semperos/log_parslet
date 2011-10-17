module LogParslet

  module RuleSet

    # Example combined log entry:
    #
    # 127.0.0.1 - frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326 "http://www.example.com/start.html" "Mozilla/4.08 [en] (Win98; I ;Nav)"
    #
    module Combined
      include Parslet
      include LogParslet::RuleSet::Base
      include LogParslet::RuleSet::Common

      rule(:referer) { (dquote >> match('[^"]').repeat >> dquote | nil_field).as(:referer) >> space }
      rule(:user_agent) { (dquote >> match('[^"]').repeat >> dquote | nil_field).as(:user_agent) >> space? }
      rule(:combined_entry) { common_entry >> referer >> user_agent }
    end

  end

end
