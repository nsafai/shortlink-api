# Radl.ink: a Shortlink-API

## Summary
A Ruby on Rails API to create custom short-links w/ Devise authentication & custom authorization

## How to use
Go to http://radl.ink and create your own custom short links. That easy!

## Technologies
This was built in Ruby on Rails w/ a PostgreSQL database. Devise for authentication. Yard for documentation. It has been deployed via Heroku.

## Documentation:
You can view documentation here: http://nicolaisafai.com/shortlink-api/

## Milestones

- [x] v0: Can CRUD basic short-links on root domain
- [x] v1: Authorization schema + exception and error handling
- [x] v2: View basic analytics on links (# clicks)
- [ ] v2.1: View other analytics demographic data like country of origin, etc.
- [ ] v3: Allow user to send analytics data back to link tracker and view full funnel
- [ ] v4: Integrate with Segment

## Useful Terminal Commands
1. To reset ENV variables from the terminal: `bundle exec figaro heroku:set -e production`
2. To migrate on prod, use: `heroku run db:rake` or `heroku run rails db:migrate`
3. To re-generate documentation from code, use: `yardoc -o docs`

### Useful links
- Live App: http://radl.ink
- Documentation: http://nicolaisafai.com/shortlink-api/
- Github: https://github.com/nsafai/shortlink-api

### Credits
- Thanks to Daniel Kehoe for the convenient starter app w/ Devise: https://github.com/RailsApps/rails-devise
- Shortlink API & front-end written by Nicolai Safai
