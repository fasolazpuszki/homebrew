require 'formula'

class StanfordParser < Formula
  homepage 'http://nlp.stanford.edu/software/lex-parser.shtml'
  url 'http://nlp.stanford.edu/software/stanford-parser-2012-07-09.tgz'
  sha1 '1d67ec99f473b59600e5698083ce518ada4dd1b2'
  version '2.0.3'

  def shim_script target_script
    <<-EOS.undent
    #!/bin/bash
    exec "#{libexec}/#{target_script}" "$@"
    EOS
  end

  def install
    libexec.install Dir['*']
    Dir["#{libexec}/*.sh"].each do |f|
      f = File.basename(f)
      (bin+f).write shim_script(f)
    end
  end

  def test
    system "#{bin}/lexparser.sh", "#{libexec}/data/testsent.txt"
  end
end
