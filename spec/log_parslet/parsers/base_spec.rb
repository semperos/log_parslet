require 'spec_helper'
require 'parslet/rig/rspec'

describe LogParslet::RuleSet::Base do
  # we'll use the smallest parser class
  # and limit our tests to the Base rule set
  let(:parser) { LogParslet.new_parser(:common).new }

  context "space" do
    subject { parser.space }
    it { should parse(' ') }
    it { should parse("\n") }
    it { should parse("\t") }
    it { should parse("\r") }
  end

  context "punctuation" do
    it { parser.lbracket.should parse('[') }
    it { parser.rbracket.should parse(']') }
    it { parser.dquote.should parse('"') }
    it { parser.slash.should parse('/') }
    it { parser.colon.should parse(':') }
    it { parser.plus.should parse('+') }
    it { parser.minus.should parse('-') }
    it { parser.dot.should parse('.') }
  end

  context "simple log date components" do
    context "date functionality" do
      subject { parser.date }
      it { should parse('1') }
      it { should parse('12') }
      it { should_not parse('123') }
    end

    context "month functionality" do
      subject { parser.month }
      it { should parse('Oct') }
      it { should parse('may') }
      it { should_not parse('February') }
      it { should_not parse('12') }
    end

    context "year functionality" do
      subject { parser.year }
      it { should parse('2008') }
      it { should_not parse('08') }
      it { should_not parse('20008') }
    end

    context "hours functionality" do
      subject { parser.hours }
      it { should parse('00') }
      it { should_not parse('1') }
      it { should_not parse('222') }
    end

    context "minutes functionality" do
      subject { parser.minutes }
      it { should parse('30') }
      it { should_not parse('5') }
      it { should_not parse('450') }
    end

    context "seconds functionality" do
      subject { parser.seconds }
      it { should parse('59') }
      it { should_not parse('3') }
      it { should_not parse('400') }
    end

    context "timezone functionality" do
      subject { parser.timezone }
      it { should parse('+0400') }
      it { should parse('-0500') }
      it { should_not parse('0600') }
      it { should_not parse('EDT') }
      it { should_not parse('America/New_York') }
      it { should_not parse('+04000') }
      it { should_not parse('-05000') }
    end
  end

  context "HTTP information about the request" do
    context "the HTTP method" do
      subject { parser.http_method }
      it { should parse('GET') }
      it { should parse('POST') }
      it { should parse('DELETE') }
      it { should_not parse('DELETES') }
      it { should_not parse('get') }
      it { should_not parse('200') }
    end

    context "the HTTP resource" do
      it "should match anything inside quotation marks" do
        parser.http_resource.should parse("foobar")
      end
    end

    context "the HTTP protocol" do
      subject { parser.http_protocol }
      it { should parse('HTTP/1.0') }
      it { should parse('HTTPS/1.0') }
      it { should_not parse('HTTP') }
      it { should_not parse('HTTP/1') }
      it { should_not parse('HTTP/1.01') }
    end
  end

# Example with parser tree structure tested
#    it { should parse(":foobar").
#      as({:keyword => {:identifier => "foobar"}}) }

end
