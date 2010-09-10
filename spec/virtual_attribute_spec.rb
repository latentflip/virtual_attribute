require 'spec_helper'
require 'rubygems'
require "virtual_attribute"

class TheTester < Tableless
  virtual_attribute :normal
  virtual_attribute :truey, :type => :boolean, :attr_type => :attr_accessible
  virtual_attribute :falsy, :type => :boolean
  virtual_attribute :nily, :type => :boolean

  virtual_attribute :dated_on, :type => :date, :attr_type => :attr_accessible
  virtual_attribute :integery, :type => :integer, :attr_type => :attr_accessible
  virtual_attribute :floaty, :type => :float, :attr_type => :attr_accessible
end

describe TheTester do
  before(:each) do
    @tester = TheTester.new
  end

  it "should create a regular virtual attribute" do
    @tester.normal = "string"
    @tester.normal.should == "string"
  end

  it "should create a boolean virtual attribute that's truey" do
    trues = ['true', 'yes', '1', 1]
    trues.each do |val|
      @tester.truey = val
      @tester.truey.should == true
    end
  end

  it "should create a boolean virtual attribute that's falsy" do
    falses = ['false', 'no', '0', 0]
    falses.each do |val|
      @tester.falsy = val
      @tester.falsy.should == false
    end
  end

  it "should create a boolean virtual attribute that's nilly" do
    nily = ['nil', '', []]
    nily.each do |val|
      @tester.nily = val
      @tester.nily.should == nil
    end
  end

  it "should create a float attribute" do
    @tester = TheTester.new(:floaty => "1.23")
    @tester.floaty.should == 1.23
  end

  it "should create nil with an incorrect float attribute" do
    @tester = TheTester.new(:floaty => "1.23f3er")
    @tester.floaty.should == nil
  end

  it "should create an integer attribute" do
    @tester = TheTester.new(:integery => "123")
    @tester.integery.should == 123
  end

  it "should create nil with an incorrect integer attribute" do
    @tester = TheTester.new(:integery => "blah")
    @tester.integery.should == nil
  end

  it "should create accessible attributes if :attr_type => accessible is used" do
    @another_tester = TheTester.new(:truey => '1')
    @another_tester.truey.should == true
  end

  it "should not create accessible attributes if :attr_type => accessible is not used" do
    @another_tester = TheTester.new(:falsy => 'no')
    @another_tester.truey.should == nil #falsy will not be saved
  end

  it "should create a date attribute" do
    @another_tester = TheTester.new({'dated_on(3i)' => "4", 'dated_on(2i)' => "10", 'dated_on(1i)' => "2010"})
    @another_tester.dated_on.should == Date.civil(2010,10,4)
  end
end
