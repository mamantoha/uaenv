# UaEnv - Ukrainian Environment for Ruby 

UaEnv - модуль для роботи з українським текстом в Ruby. Головна ціль UaEnv - полегшити
розробку україномовних програм на Ruby.

Версія > 0.0.6 не підтримує Ruby < 1.9.0

Величезне спасибі Julik і Mash - розробникам RuTils, на основі якого побудований UaEnv.


## Cума прописом

UaEnv реалізує суму прописом для цілих і дробових чисел із додатковим врахуванням роду. Наприклад:

```ruby
15.propysom => "п'ятнадцять"
1357472.propysom => "один мільйон триста п'ятдесят сім тисяч чотириста сімдесят два"
901.propysom(2) => "дев'ятсот одна"
624.propysom_items(2,'книжка','книжки','книжок') => "шістсот двадцять чотири книжки"
```

Вибір варіанта числівника в залежності від числа

```ruby
7.items('самурай','самураї','самураїв') => "самураїв"
```

і вивід "суми прописом" для сум у гривнях

```ruby
(666.13).grn => "шістсот шістдесят шість гривень тринадцять копійок"
```

## Дати

Введені наступні константи:

* `UA_ABBR_DAYNAMES` (нд пн вт ...)
* `UA_DAYNAMES_E` (перше друге третє ...)
* `UA_ABBR_MONTHNAMES` (січ лют бер ...)
* `UA_INFLECTED_MONTHNAMES` (січня лютого березня)
* `UA_DAYNAMES` (неділя понеділок вівторок)
* `UA_MONTHNAMES` (січень лютий березень)

Приклад використання:

```ruby
require 'date'
date = Date.new(2007, 01, 5)
puts "#{UaEnv::UaDates::UA_ABBR_MONTHNAMES[date.mon]}" => січ
puts "#{UaEnv::UaDates::UA_DAYNAMES[date.wday]}" => п'ятниця
```

Починаючи з версії 0.0.9 не відбувається "перекриття" стандартної
функції `Time#strftime`:

```ruby
Time.local(2007,"jan",5).ua_strftime("%a, %A, %b, %B") => "пт, п'ятниця, січ, січень"
Time.local(2007,"jan",5).strftime("%a, %A, %b, %B") => "Fri, Friday, Jan, January"
Time.now.ua_strftime("Сьогодні %A, %d %B %Y року, %H:%M:%S") => "Сьогодні субота, 6 січня 2007 року, 14:50:34"
```

## Відстань між двома датами

Приблизна відстань між двома цілими числами в секундах:

```ruby
UaEnv::UaDates.distance_of_time_in_words(0, 31, true) => "півхвилини"
UaEnv::UaDates.distance_of_time_in_words(0, 140) => "2 хвилини"
UaEnv::UaDates.distance_of_time_in_words(0, 60 * 120 + 60 * 60) => "близько 3 годин"
UaEnv::UaDates.distance_of_time_in_words(60 * 60 * 24 * 3) => "3 дні"
```

## Транслітерація

Транслітерація української кирилиці у латиницю (національна):

```ruby
"Привіт, як ся маєш?".translify => "Pryvit, yak sia maiesh?"
"Привіт, як ся маєш?".translify_national => "Pryvit, yak sia maiesh?"
```

Транслітерація української кирилиці у латиницю (ISO9):

```ruby
"Привіт, як ся маєш?".translify_iso9a => "Privìt, âk sâ maêš?"
```

Текст кодується так, як ніби він набраний на qwerty-клавіатурі (winkeys) з неправильною активно розкладкою (en замість ua). Кодування відбувається в обидві сторони:

```ruby
UaEnv::Transliteration::QWERTY::decode_ua("Ghbdsn? zr cghfdb") => "Привіт, як справи"
UaEnv::Transliteration::QWERTY::decode_lat("Руддщб рщц фку нщг") => "Hello, how are you"
```

## Відмінювання прізвища, імені і по батькові

Відміняє призвище, ім'я і по батькові у давальний відмінок. Ця функція потребує серйозної доводки.

```ruby
UaEnv::FIO::dative_case("Іванченко", "Іван", "Іванович") => ["Іванченку", "Івану", "Івановичу"]
```
## License

Copyright (c) 2007-2012 Anton Maminov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
