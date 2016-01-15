#Summary
This is a interview task I did. Push to Github one year later. Some part I have a better way to do it. But in general it is some code that I proud of. I want to keep it here, when I have time I'll keep refactoring this code to make it like an exericse.

Written in Ruby. Rspec for testing. Very high test coverage. TDD
Gem style, README in Github style markdown. Pretty much is what a Gem repo in Github should look like.

#How to use
After unzip run and cd my dir
```shell
gem install sales_taxes-1.0.0.gem
cd demo
sales_taxes_cal input1.txt
```

```shell
higgins-55-194% sales_taxes_cal input1.txt
1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83
```

*Of course you may not really want my program in your env*

Or just

```shell
bin/sales_taxes_cal demo/input1.txt
```

#Run Test
I spent a huge amount of effort to write tests as a normal Ruby programmer.
And I am using TDD, there is some design change in the middle tho.
You get git log to check my log if you have interest.
The tests are well written as well.
```shell
rspec
```

#Assumption
3 books at 3.00 means each book is 1.00, total of 3 should be 3.00

multiple tax is calculate as round(47.50 * 0.10 + 47.50 * 0.05 + 47.50) instead of
(47.50 * 1.15)

#What I am in mind

* Decoupling
* Maintainable first
* TDD
* Immuntable
* Refactoring
* The requirement will change anytime
* Use less inherent
* User more block, potentially better concurrency
* Readability(can be understood without comments)
* Robust
* Anti-fancy algorithm trick

#Structure & Algorithm
```shell
|-- Gemfile
|-- Gemfile.lock
|-- LICENSE.txt
|-- README.md
|-- Rakefile
|-- bin
|   -- sales_taxes_cal
|-- demo <---------------- some test we can play with
|   |-- input1.txt
|   |-- input2.txt
|   |-- input3.txt
|   |-- input_du.txt
|   |-- input_random.txt
|   `-- input_too_long.txt
|-- lib <---------------------------- main logic
|   |-- basic_sales_tax.rb
|   |-- helper.rb
|   |-- import_sales_taxes.rb
|   |-- item.rb
|   |-- sales_taxes
|   |   -- version.rb
|   |-- sales_taxes.rb
|   `-- taxes_line_parser.rb
|-- sales_taxes-1.0.0.gem
|-- sales_taxes.gemspec
`-- spec  <---------------------------- tests
    |-- basic_sales_tax_spec.rb
    |-- helper_spec.rb
    |-- import_sales_tax_spec.rb
    |-- item_spec.rb
    |-- line_parser_spec.rb
    |-- sales_taxes_spec.rb
    `-- spec_helper.rb
```

The algorithm itself is not complex. I hope you can understand it by just read SalesTaxes::apply_sales_taxes.

##Regex
I use *LineParser* to parse each line to *Item* object. When parsing, I use Regex. The input seems can be parsed be [quantity] of [name] at [price], and parse each one of them. But it has very poor extensibilty. If the input structure changed. Three of them cannot be used anymore. So I just use Regex.

##Item Class
Item class is an immutable class. Once initialized, it cannot be changed. When name, price, import condition are same, they are considered same. In this way, I can remove dulplication using hash.

##All my duck in a row
I wrapped taxes calculation in BasicSalesTax, ImportSalesTaxes. In this way, I can let them apply to items one by one. When there is a new tax come out, we can simply add a new class. Also, the tax rate can be assigned when initialize. There are a few duplicate code in these two, so I didn't use inherent.

_bin/sales_taxes_cal is just read the file into array, is it not well tested, since there is framework like Thor to handle everything.**

#Demo
```shell
higgins-55-194% ls
input1.txt  input3.txt	  input_random.txt
input2.txt  input_du.txt  input_too_long.txt
higgins-55-194% sales_taxes_cal  input1.txt
1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83
higgins-55-194% sales_taxes_cal  input2.txt
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
higgins-55-194% sales_taxes_cal  input3.txt
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
1 imported box of chocolates: 11.85
Sales Taxes: 6.70
Total: 74.68
higgins-55-194% sales_taxes_cal  input_du.txt
1 imported bottle of perfume: 32.19
3 bottle of perfume: 62.67
1 packet of headache pills: 9.75
2 imported box of chocolates: 23.65
Sales Taxes: 11.05
Total: 128.26
higgins-55-194% cat  input_du.txt
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
1 bottle of perfume at 18.99
1 box of imported chocolates at 11.25
1 bottle of perfume at 18.99
1 box of imported chocolates at 11.25
higgins-55-194% sales_taxes_cal  input_too_long.txt
Sorry: Somthing wrong with the input The line is too long. Probably is not the correct file.
higgins-55-194% sales_taxes_cal input_random.txt
Sorry: Somthing wrong with the input No price in this line i am a random file
higgins-55-194% cat input_random.txt
i am a random file
higgins-55-194%
```

#Question
Sales Taxes

Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt. Import duty is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.

When I purchase items I receive a receipt which lists the name of all the items and their price (including tax), finishing with the total cost of the items, and the total amounts of sales taxes paid.  The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.

Write an application that prints out the receipt details for these shopping baskets...
INPUT:

Input 1:
1 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85

Input 2:
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50

Input 3:
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
1 box of imported chocolates at 11.25

OUTPUT

Output 1:
1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83

Output 2:
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15

Output 3:
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
1 imported box of chocolates: 11.85
Sales Taxes: 6.70
Total: 74.68
