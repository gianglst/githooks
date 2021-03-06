require "spec_helper"
require "support/shared_examples.rb"

load "pre_commit/checkers/rspec_expect_to_receive_checker.rb"

RSpec.describe RspecExpectToReceiveChecker do
  let(:checker_class) { RspecExpectToReceiveChecker }

  context "code without any issues" do
    subject(:checker) { test_class_with_change(checker_class, "Hello") }
    it_should_behave_like "it finds no error"
  end

  context "code with an expect to have_received" do
    subject(:checker) { test_class_with_change(checker_class, "expect(a).to have_received") }
    it_should_behave_like "it finds no error"
  end

  context "code with a expect to receive" do
    subject(:checker) { test_class_with_change(checker_class, "expect(a).to receive") }
    it_should_behave_like "it finds an error"
  end

  context "code with a expect to receive" do
    subject(:checker) { test_class_with_change(checker_class, "expect(a).to_not receive") }
    it_should_behave_like "it finds an error"
  end
end
