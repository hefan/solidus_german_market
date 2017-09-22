module SolidusGermanMarket
  module Generators
    class ConvertProductsGenerator < Rails::Generators::Base

      def run_migrations
        default_shipping_cat = Spree::ShippingCategory.find_by(name: "Standard Deutschland")
        default_tax_cat = Spree::TaxCategory.find_by(name: "Standard")

        if default_shipping_cat.blank?
          puts "no default shipping category from solidus_german_market ('Standard Deutschland') found, did you run solidus_german_market:install ?"
        elsif default_tax_cat.blank?
          puts "no default tax category from solidus_german_market ('Standard') found, did you run solidus_german_market:install ?"
        else
          Spree::Product.all.each do |p|
            next if p.price.blank?
            p.tax_category = default_tax_cat
            p.shipping_category = default_shipping_cat
            p.cost_currency = "EUR"
            p.master.tax_category = default_tax_cat
            p.variants.all.each do |v|
              next if v.price.blank?
              v.tax_category = default_tax_cat
              v.cost_currency = "EUR"
              v.save!
            end
            p.save!
            puts "put #{p.name} prices as euro and in german shipping and tax categories"
          end
          Spree::Order.where("state != 'complete'").each do |o|
            o.currency = "EUR"
            o.save!
            puts "currency of order #{o.number} is now Euro"
          end
        end
      end

    end
  end
end
