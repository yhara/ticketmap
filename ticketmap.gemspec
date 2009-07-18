# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ticketmap}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yutaka HARA"]
  s.date = %q{2009-07-18}
  s.description = %q{Two-dimentional ToDo manager}
  s.email = %q{yutaka.hara/at/gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     ".gitmodules",
     "MANIFEST",
     "README.rdoc",
     "Rakefile",
     "TODO",
     "VERSION",
     "controller/config.rb",
     "controller/init.rb",
     "controller/main.rb",
     "controller/tickets.rb",
     "db/migrate/001_create_tickets.rb",
     "db/migrate/002_add_deleted_to_tickets.rb",
     "db/migrate/003_add_timeouted_to_tickets.rb",
     "dot.tickets.conf.sample",
     "main.rb",
     "model/init.rb",
     "model/ticket.rb",
     "public/biwascheme/lib/biwascheme.js",
     "public/biwascheme/lib/dumper.js",
     "public/biwascheme/lib/extra_lib.js",
     "public/biwascheme/lib/io.js",
     "public/biwascheme/lib/prototype.js",
     "public/biwascheme/lib/r6rs_lib.js",
     "public/biwascheme/lib/stackbase.js",
     "public/biwascheme/lib/webscheme_lib.js",
     "public/js/builder.js",
     "public/js/controls.js",
     "public/js/dragdrop.js",
     "public/js/effects.js",
     "public/js/scriptaculous.js",
     "public/js/slider.js",
     "public/js/sound.js",
     "public/js/unittest.js",
     "public/scm/board.scm",
     "public/scm/hand.scm",
     "public/scm/main.scm",
     "public/scm/server.scm",
     "public/scm/ticket.scm",
     "spec/config.rb",
     "spec/helper.rb",
     "spec/main.rb",
     "spec/models.rb",
     "spec/tickets.rb",
     "ticketmap.gemspec",
     "tickets.gemspec",
     "view/index.xhtml",
     "view/track.xhtml"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/yhara/ticketmap}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Two-dimentional ToDo manager}
  s.test_files = [
    "spec/config.rb",
     "spec/helper.rb",
     "spec/main.rb",
     "spec/models.rb",
     "spec/tickets.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ramaze>, ["= 2009.06.12"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_runtime_dependency(%q<do_sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<ramaze>, ["= 2009.06.12"])
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<do_sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<ramaze>, ["= 2009.06.12"])
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<do_sqlite3>, [">= 0"])
  end
end
