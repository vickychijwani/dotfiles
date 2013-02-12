alias grepr='grep --recursive --line-number --exclude=*~ --exclude-dir=.git'
alias diff='colordiff -u'

# apt aliases
alias agi='sudo apt-get install'
alias agp='sudo apt-get purge'
alias aga='sudo apt-get autoremove'
alias agug='sudo apt-get upgrade'
alias agud='sudo apt-get update'

# check which HTTP proxies are working using a list of them in ~/.prxy
alias prxyall="nmap -iL ~/.prxy -p 8080 -PN -n|grep open -B 3|sed '/.*PORT*/ d'|sed '/Host is up*/ d'|sed '/8080*/ d'|sed '/--/ d'|sed 's/Nmap scan report for //'"

# download websites for offline use. If wget-website seems to be leaving out images or other files, try using wget-website-diff
alias wget-website='wget -mkpE -np'
alias wget-website-diff='wget -mpHEKk -np'


alias rsync='rsync --stats --progress -av'
alias minify='java -jar ~/Web\ Development/yuicompressor-2.4.2.jar'

# append "; alert" after any command to be notified of its completion (requires libnotify)
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1| sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# rvm and ruby-gems commands
alias rgl='rvm gemset list'
alias rgu='rvm gemset use'
alias rgc='rvm gemset create'
alias rgd='rvm gemset delete'
alias gl='gem list'
alias gi='gem install --no-ri --no-rdoc'
