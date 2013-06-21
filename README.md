cordage
=======

Flexible record based associations in ActiveFedora models.


#### Install

```
gem install cordage
```

#### Example


```ruby
  # app/models/video.rb
  class Video < ActiveFedora::Base
    cordage :managers, class_name: 'User'
  end
```

```ruby
  # app/controllers/videos_controller.rb
  video = Video.new
  video.managers << User.first
  video.save
```


#### Options

```ruby
  cordage :managers,
    class_name: 'User',  # required if different than association name
    primary_key: 'id', # optional
```