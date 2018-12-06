# Shortlink-API

## The Idea
A Ruby on Rails API to create custom short-links w/ 2FA

## Milestones

- v0: Can CRUD basic short-links on root domain
- v1: Auth + view own links
- v2: View analytics on links (# clicks, country of origin, etc.)
- v3: Allow user to send analytics data back to link tracker and view full funnel
- v4: Integrate with Segment

## Things to fix
- [ ] password reset link goes to gmail.com/users/password/....

## Useful Terminal Commands
1. To reset ENV variables from the terminal: `bundle exec figaro heroku:set -e production`
2. To migrate on prod, use: `heroku run db:rake`

## Functional Requirements

- [x] At least one nested route or resource.
- [x] The ability to CREATE, READ, UPDATE, and DELETE the object(s) in your API.
- [x] At least one of each endpoint: GET, POST, PUT, and DELETE.
- [ ] A database persistence layer (e.g. MongoDB)
- [ ] Project contains documentation explaining how to use your API.
- [ ] Project contains a simple, static single page brochure site that explains what the API does and a link to the API's documentation.

## Non-Functional Requirements

- [x] The API must be written using the appropriate application of RESTful techniques.
- [x] The API implementation must follow the MVC pattern.
- [x] The API must be hosted in a public GitHub repository.
- [x] The project repository should not expose any secrets!
- [x] The API must have a discernible theme or serve a distinct purpose. See the Examples for well-themed and purposed APIs.
- [x] The final project must be deployed and fully accessible via the internet and callable via any consumer.
- [ ] The final project must be fully documented.

### Credits
- Shortlink API written by Nicolai Safai
- Credit to Daniel Kehoe @ RailsApps for the convenient starter app w/ Devise: https://github.com/RailsApps/rails-devise
