# cookie_slasher

## Synopsis

Rack middleware, removes cookies from responses that are likely to be accidentally cached.

## Audience

Use this gem as an extra layer of protection if your system has any HTTP
accelerator in front of it, like Varnish. And by the way, Fastly is all
about Varnish.

## Why?

It is often desirable to create configuration of accelerator that caches 404
(Page Not Found) and 301 (Permanent Redirect) responses. It is only too
easy to make a trivial mistake and cache those pages even when there are
cookies set on them.

### Consequences of not using it

If session cookie is set on a 404 or 301 response (typical), and that
response is cached by HTTP accelerator, your users will suddengly see
themself logged in as somebody else, and user session swapping will go
wild. Then you will spend days or weeks troubleshooting this problem,
because even reproducing it is a challenge. All while users confidence
in your system plummets.

### Chances of having 'session swapping' problem

Fairly small, but you are always only one step away from it, and
consequences are dire.

## Usage

First, add this line to your Gemfile

    gem 'cookie_slasher'

Second, if you have Rails app, add this line to config/application.rb

    config.middleware.insert_before ActionDispatch::Cookies, CookieSlasher

If you have Rack/Sinatra/... app, you just have to 'use' CookieSlasher
middleware close to the top of your rackup configuration.

Third, test to make sure it actually works for you.

### Logging

CookieSlasher always logs cookies it is removing from response to avoid
any surprises. If your app is Rails app, it logs to standard rails
logger. If not, it logs to 'rack.error' stream, or to logger provided in
configuration. If you feel like complaining that its log is too verbose
and noisy, read next paragraph.

### Abuse

Relying on it to catch ALL your cookies (especially session cookies) ALL
the time will work, but is considered to be an abusive behavior.
CookieSlasher is just a safeguard, it is not intended to be actively
working all the time removing those cookies from requests. It can do
that, but that is just bad taste and design. If you see in your
application log that CookieSlasher is often removing cookies, please do work
on your application code to make it stop creating them in the first
place. If you have Rails app, this line of code may come in handy:

    request.session_options[:skip] = true
