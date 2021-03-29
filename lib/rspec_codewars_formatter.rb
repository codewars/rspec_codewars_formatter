# frozen_string_literal: true

require "time"

require "rspec/core"
require "rspec/core/formatters/base_formatter"
require "rspec/expectations"

class RSpecCodewarsFormatter < RSpec::Core::Formatters::BaseFormatter
  VERSION = "0.1.0"

  RSpec::Core::Formatters.register self,
    :example_group_started,
    :example_group_finished,
    :example_started,
    :example_passed,
    :example_failed,
    :example_skipped,
    :message

  def initialize(output)
    super

    @group_starts = []
    @example_start = nil
  end

  def example_group_started(notification)
    output.puts "\n<DESCRIBE::>#{escape_lf(notification.group.description.strip)}"
    @group_starts.push(Time.now)
  end

  def example_group_finished(_notification)
    completed_span(@group_starts.pop)
  end

  def example_started(notification)
    output.puts "\n<IT::>#{escape_lf(notification.example.description.strip)}"
    @example_start = Time.now
  end

  def example_passed(_notification)
    output.puts "\n<PASSED::>Test Passed"
    completed_span(@example_start)
  end

  def example_pending(_notification)
    output.puts "\n<LOG::>Test Pending"
    completed_span(@example_start)
  end

  def example_failed(notification)
    ex = notification.exception
    if ex.is_a?(RSpec::Expectations::ExpectationNotMetError)
      output.puts "\n<FAILED::>#{escape_lf(ex.to_s.strip)}"
    else
      backtrace = notification.formatted_backtrace
      msg = escape_lf("#{backtrace.first}: #{ex.message} (#{exception_class_name(ex)})")
      output.puts "\n<ERROR::>#{msg}"
      if backtrace.size > 1
        output.puts "\n<LOG::-Backtrace>#{backtrace.drop(1).join("<:LF:>")}"
      end
    end
    completed_span(@example_start)
  end

  def message(notification)
    output.puts notification.message
  end

  private

  def completed_span(start)
    duration = (Time.now - start)*1000
    output.puts "\n<COMPLETEDIN::>#{duration.round(4)}"
  end

  def exception_class_name(exception)
    name = exception.class.name.to_s
    name == "" ? "anonymous" : name
  end

  def escape_lf(msg)
    msg.gsub("\n", "<:LF:>")
  end
end

RspecCodewarsFormatter = RSpecCodewarsFormatter
