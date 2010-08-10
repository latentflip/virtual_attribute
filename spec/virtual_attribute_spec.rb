require 'spec_helper'
require 'rubygems'
require "virtual_attribute"

class TheTester < Tableless
  virtual_attribute :normal
  virtual_attribute :truey, :boolean => true, :attr_type => :attr_accessible
  virtual_attribute :falsy, :boolean => true
  virtual_attribute :nily, :boolean => true
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

  it "should create accessible attributes if :attr_type => accessible is used" do
    @another_tester = TheTester.new(:truey => '1')
    @another_tester.truey.should == true
  end

  it "should not create accessible attributes if :attr_type => accessible is not used" do
    @another_tester = TheTester.new(:falsy => 'no')
    @another_tester.truey.should == nil #falsy will not be saved
  end
end
