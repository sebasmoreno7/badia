## Security update (November 2026)

The dependency lockfile now requires Rails 8.1.4.1 and Rack 3.2.8, together with
patched Addressable, Crass and SQLite3 gems. Ruby is 3.4.12. The existing tests,
IP-spoofing regression tests, production asset build and bundler-audit pass.

For deployments, the reverse proxy must remove or overwrite client-supplied
`Forwarded` headers and set a trustworthy `X-Forwarded-For`. The Rails patch
checks contradictory headers; it cannot repair an incorrectly configured proxy.
See https://github.com/rails/rails/security/advisories/GHSA-2gff-2mmg-m73p.

# Badia · Rails posts and articles exercise

This repository is a learning app with Devise accounts, posts and articles. A live deployment is not confirmed.

## Local development

- Ruby 3.4.12, Bundler, and SQLite
- Rails 8.1.4, Devise 5.0.4, Propshaft, and Importmap
- `bundle install`
- `RAILS_ENV=test bin/rails db:prepare && bin/rails test`
- `bin/rails db:prepare && bin/rails server`

No Node or Yarn build is required. Placeholder RSpec files with no examples were removed. GitHub Actions checks tests, asset compilation, and Ruby advisories.

## Upgrade and deployment review

This upgrade replaces Rails 6.0/Ruby 2.7 and Webpacker/Turbolinks. Delete links now use Turbo's method and confirmation attributes. Review those controls and Devise account flows in a browser before merging. Bootstrap's CSS CDN remains; any Webpacker JavaScript behavior is gone. The application retains Rails 6.0 configuration defaults for a staged review.

Production now requires a separately managed PostgreSQL `DATABASE_URL` and a securely provided Rails secret. Local SQLite data will **not** move automatically. Back up and migrate any real database explicitly. Active Storage still uses local disk; choose persistent object storage and plan any upload transfer before deploying to an ephemeral host. `config.force_ssl` is enabled. No production database migration or deployment is included in this PR.

Devise password resets require outbound email, which is not configured for a free host; [Render Free blocks common SMTP ports](https://render.com/docs/free). Choose a permitted HTTP email service and its credentials before relying on password recovery. No custom jobs or Action Cable subscriptions exist; the generated production Cable config still references Redis and would need review if real-time features are added.

Confirm the existing app and database, test against a staging copy, and preserve a rollback deployment and database backup before rollout. Reverting code cannot undo data transfer or schema changes. A clean dependency audit only addresses advisories in its database at that moment.
