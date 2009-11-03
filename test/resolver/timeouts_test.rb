require 'test_helper'
require 'net/dns/resolver/timeouts.rb'

class DnsTimeoutTest < Test::Unit::TestCase
  
  def test_timeout_should_raise_localjumperror_without_block
    assert_raise(LocalJumpError) { DnsTimeout.new(1).timeout }
  end
  
  def test_tcp
    assert_equal(TcpTimeout.new(0).to_s,"infinite")
    assert_equal(TcpTimeout.new(30).to_s, "30")
    assert_equal(TcpTimeout.new(30).pretty_to_s, "30 seconds")
    assert_equal(TcpTimeout.new(90).pretty_to_s, 
                 "1 minutes and 30 seconds")
    assert_equal(TcpTimeout.new(3690).pretty_to_s, 
                 "1 hours, 1 minutes and 30 seconds")
    assert_equal(TcpTimeout.new(1).timeout {1+1}, 2)
  end

  def test_udp
    assert_equal(UdpTimeout.new(0).to_s,"not defined")
    assert_equal(UdpTimeout.new(30).to_s, "30")
    assert_equal(UdpTimeout.new(30).pretty_to_s, "30 seconds")
    assert_equal(UdpTimeout.new(90).pretty_to_s, 
                 "1 minutes and 30 seconds")
    assert_equal(UdpTimeout.new(3690).pretty_to_s, 
                 "1 hours, 1 minutes and 30 seconds")
    assert_equal(UdpTimeout.new(1).timeout {1+1}, 2)    
  end
  
  def test_range_tcp
    assert_raise(ArgumentError) do
      TcpTimeout.new("a")
    end
    assert_raise(ArgumentError) do
      TcpTimeout.new(-1)
    end
    assert_raise(TimeoutError) do
      TcpTimeout.new(0.1).timeout {sleep 2}
    end
  end

  def test_range_udp
    assert_raise(ArgumentError) do
      UdpTimeout.new("a")
    end
    assert_raise(ArgumentError) do
      UdpTimeout.new(-1)
    end
    assert_raise(TimeoutError) do
      UdpTimeout.new(0.1).timeout {sleep 2}
    end
  end

end

class TcpTimeoutTest < Test::Unit::TestCase
  
  def test_timeout_should_raise_localjumperror_without_block
    assert_raise(LocalJumpError) { TcpTimeout.new(1).timeout }
  end
  
end

class UdpTimeoutTest < Test::Unit::TestCase
  
  def test_timeout_should_raise_localjumperror_without_block
    assert_raise(LocalJumpError) { UdpTimeout.new(1).timeout }
  end
  
end
