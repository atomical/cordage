cordage
=======

Flexible record based associations in ActiveFedora models.


#### Install

```
gem install cordage
```

### Example

```ruby
  class Video < ActiveFedora::Base
    cordage :managers, class_name: 'User', primary_key: 'id'
  end
```

```ruby
  video = Video.new
  video.managers << User.first
  video.save
```

