class pandoc {
    package { [
      "pandoc"
      ,"texlive-latex-base"
      ,"texlive-xetex"
      ,"texlive-latex-extra"
      ,"texlive-fonts-extra"
      ,"texlive-math-extra"
      ,"latex-beamer"
    ]:
    ensure => present
  }
}
