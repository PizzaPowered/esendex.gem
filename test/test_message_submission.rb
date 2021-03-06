require 'helper'

class TestMessageSubmission < Test::Unit::TestCase
  should "format scheduled date time correctly" do
    # yyyy-MM-ddThh:mm:ss
    
    target_time = Time.local(2011, 4, 7, 15, 0, 0)
    
    submission = Esendex::MessageSubmission.new("EX1234556", [Message.new("0777111222", "I'm sending this in the future")])
    submission.send_at = target_time
    
    assert_equal "2011-04-07T15:00:00", submission.xml_node.elements["//messages/sendat"].text
  end
  
  should "contain multiple messages" do   
    submission = Esendex::MessageSubmission.new("EX1234556", [Message.new("0777111222", "I'm sending this in the future"), Message.new("0777111333", "I'm sending this in the future")])
    
    message_elements = submission.xml_node.elements["//messages/message"]
    
    assert_equal 2, message_elements.count
  end
end