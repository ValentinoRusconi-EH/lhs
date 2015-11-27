LHS
===

LHS uses [LHC](//github.com/local-ch/LHC) for http requests.

## Service
A service connects your application to backend endpoints and provides you access to their data.

```ruby
class Feedback < LHS::Service

  endpoint ':datastore/v2/content-ads/:campaign_id/feedbacks'
  endpoint ':datastore/v2/feedbacks'

end

data = Feedback.where(has_reviews: true) #<LHS::Data>
```

→ [Read more about services](docs/services.md)

## Data
An instance of LHS::Data contains raw data (json) and a proxy that is used to access data.

```ruby
Service.where #<LHS::Data @_proxy_=#<LHS::Collection>>
Service.find(123) #<LHS::Data @_proxy_=#<LHS::Item>>
```

→ [Read more about data](docs/data.md)

## Proxy
A proxy is used to access data. It is divided in Collection and Item.

For every proxy that contains an `href` you can use `load!` or `reload!` to receive latest backend data.

```ruby
{
  "href" => "http://local.ch/v2/content-ads/51dfc5690cf271c375c5a12d"
}

item.load!.id
item.reload! # loads it again
item.load! # wont load it again, because its already arround
```

## Collection
A collection contains multiple items.

```ruby
data = Feedback.where(has_reviews: true) #<LHS::Data @_proxy_=#<LHS::Collection>>
data.count # 10
data.total # 98
```

→ [Read more about collections](docs/collections.md)

## Item
An item is a concrete record. It can be part of another proxy like collection.

```ruby
data = Feedback.where(has_reviews: true).first #<LHS::Data @_proxy_=#<LHS::Item>>
data.recommended # true
data.created_date # Fri, 19 Sep 2014 14:03:35 +0200
```

→ [Read more about items](docs/items.md)
