SolidusGermanMarket
===================

Configure and extend solidus for being more german market ready.

- Changes address field order in the checkout address
- Adds a german zone, german tax categories/rates and a default flat german shipping method.
- Remove germany from all other zones.


Installation
------------

Add solidus_german_market to your Gemfile:

```ruby
gem 'solidus_german_market', github: 'hefan/solidus_german_market'
```


Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g solidus_german_market:install
```


Setup
-----

Add products with the appropriate shipping and tax categories to your shop and you're done.

To

- Set germany as default zone and default country id.
- Set Euro (EUR) as default currency
- not require state in the checkout process

you may add the following to your config/initializers/spree.rb

```shell
config.default_country_iso = "DE"

config.address_requires_state = false
config.checkout_zone = "Deutschland"

config.currency = "EUR"
```


Also you may add the following to your config/application.rb:

- 'de' as i18n default locale of your application `config.i18n.default_locale = :de`
  - you have to add solidus_i18n for that, see https://github.com/solidusio-contrib/solidus_i18n

- 'Berlin' as the time_zone of your application `config.time_zone = 'Berlin'`


Convert products
----------------

If you want to move all existing Products
 - to the newly created shipping category
 - to the newly created tax category

and set the currencies of all products and incompleted orders to "EUR" (without altering the prices) use

```shell
bundle exec rails g solidus_german_market:convert_products
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
```
