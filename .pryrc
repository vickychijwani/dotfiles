# add pwd to PATH
$: << "."

# default editor for 'edit' and 'edit-method'
Pry.config.editor = "emacsclient -a '' -t"

# make awesome_print work with pry
begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
rescue LoadError => err
  puts "no awesome_print :("
end

# use awesome_print by default
AwesomePrint.pry!

## plugins
# pry-theme
Pry.config.theme = "zenburn"

# pry-coolline
Pry.config.coolline_paren_matching = true
Pry.config.coolline_matched_paren = "\e[42m"
Pry.config.coolline_mismatched_paren = "\e[41m"
