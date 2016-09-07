# Anagramalama

This project is a code test submission for Ibotta's platform developer position. It is a very basic anagram API allowing users to:
* Add words to the corpus
* Get anagrams of a word
* Delete a word
* Clear all data from the corpus

## Dependencies
* Ruby 2.0.0+ (2.3.0p0 used)
* Rails 5.0.0.1
* PostGres 9.5.0.0

## Setting up
Once project is extracted or cloned, `cd anagramala` and:
1. `bundle install`
2. `rails db:create`
3. `rails db:migrate`
4. `rails s`

You'll have a server running with an empty corpus on `localhost:3000`.

To run the tests, from application root type: `rspec`

**Note:** For those looking at this on BitBucket, I ordinarily wouldn't put the database.yml file into version control, but the file contains no secrets as there is no database password required right now.

## The API
#### POST /words.json
**Description:** Add words

Request:
```shell
curl -i -X POST -H "Content-Type:application/json" -d '{ "words": ["read", "dear", "dare"] }' http://localhost:3000/words.json`
```
Response:
```json
HTTP/1.1 201 Created
...
{
  "added":
    [
      "read",
      "dear",
      "dare"
    ],
    "rejected":[]
}
```
**Note:** Words are rejected if they're not in the application's dictionary or are already in the corpus.

#### GET /anagrams/:word.json
**Description:** Look up anagrams of a word

Options: `?limit={n}` -- sets maximum number of anagrams returned

Request:
```shell
curl -i http://localhost:3000/anagrams/read.json
```

Response:
```json
HTTP/1.1 200 OK
...
{
  "anagrams":
  [
    "dear",
    "dare"
  ]
}
```

#### Delete a word
Request:
```shell
curl -i -X DELETE http://localhost:3000/words/read.json
```

Response:
```json
HTTP/1.1 200 OK
...
```

#### Delete all words
Request:
```shell
curl -i -X DELETE http://localhost:3000/words.json
```

Response:
```json
HTTP/1.1 204 No Content
...
```

## Design overview and trade-offs
First, I decided on a SQL data store mostly because it's familiar, robust, and powerful. However, this is the sort of system that would work just as well with a key value store where the stored word is the key. Ultimately, I think the SQL database with and index on the sorted word is faster, but may not be fast enough to make the heavier overhead worth it in the long run.

I started to implement this in Sinatra because it's a lightweight API requiring very few endpoints. If it had to scale much larger, however, Rails would still be a better choice. However, I primarily switched to Rails when I realized integrating Active Record with Sinatra was going to cost me a lot more time for very little value. So, I went with the more familiar and robust Rails. I created this project without mailers, as it doesn't need them. I also passed the `--api` flag to keep it as lightweight as possible.

I opted not to use any JSON templating at this point because none of the endpoints were complex enough to warrant the overhead. Serializers aren't necessary, either, given the API's response requirements, though that warrants discussion. I prefer to develop light until a need shows itself.

## Encountered edge cases
1. `POST /words.json` always returns a 201, but it shouldn't if all words in the request are rejected.
2. Anagram.rb is case insensitive, so Green and green are considered unique. We may want to change it; worth considering.

## Future features
