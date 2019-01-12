## xstorename

Simple native ruby wrapper for Xlib's XStoreName

Silly, but useful for ruby scripts that interact with dwm so you don't have to shell out to xsetroot.

### Usage:

`gem install xstorename`

```ruby
#!/usr/bin/env ruby
require 'XStoreName'

loop do
  sleep 1
  XStoreName.set_name(Time.now.to_s)
end
```
