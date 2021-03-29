# frozen_string_literal: true
require "pty"
require "stringio"
require "pathname"

RSpec.describe RSpecCodewarsFormatter do
  # Always run fixtures from the project root for consistent error message paths.
  PROJECT_ROOT = File.expand_path("../../", __FILE__)
  FIXTURES_DIR = File.expand_path("../fixtures/", __FILE__)

  def get_spec_output(file)
    command = [
      "bundle", "exec",
      "rspec",
      "-r", "rspec_codewars_formatter",
      "--format", "RSpecCodewarsFormatter",
      file
    ]
    output = StringIO.new
    PTY.spawn(*command, chdir: PROJECT_ROOT) do |r, w, pid|
      begin
        r.each_line { |line| output.puts(line) }
      rescue Errno::EIO
        # Finished
      ensure
        Process.wait pid
      end
    end
    output.string
  end

  # Strip duration and make line endings irrelevant.
  def normalize(str)
    str.gsub(/(?<=<COMPLETEDIN::>).+$/, "").encode(universal_newline: true)
  end

  Dir["#{FIXTURES_DIR}/*_spec.rb"].each do |file|
    relative_path = Pathname.new(file).relative_path_from(Pathname.new(PROJECT_ROOT)).to_s
    it relative_path do
      expected = File.read(file.sub(/\.rb$/, ".expected.txt"))
      actual = get_spec_output(relative_path)
      expect(normalize(actual)).to eq(normalize(expected))
    end
  end
end
