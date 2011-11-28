$: << 'lib'

require 'github'

r = GitHub.repo('malkier', 'kythera')
r
r.commits
r.commits.first
r.commits.first.comments
