# Anagramalama

This project is a very basic anagram API allowing users to:
* Add words to the corpus
* Get a word's anagrams
* Delete a word
* Clear all data from the corpus

## Dependencies
* Ruby 2.0.0+ (2.3.0p0 used)
* Rails 5.0.0.1
* Postgres 9.5.0.0

## Setting up
Once project is extracted or cloned, `cd anagramalama` and:
1. `bundle install`
2. `rails db:create`
3. `rails db:migrate`
4. `rails s`

You'll have a server running with an empty corpus on `localhost:3000`.

To run the tests, from application root type: `rspec`

**Note:** I ordinarily wouldn't put the database.yml file into version control, but the file contains no secrets as there is no database password required right now.

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

#### GET /corpus/details.json
**Description:** Returns the following corpus information:
* Word count
* Shortest word length
* Longest word length
* Average word length
* Median word length

Request:
```shell
curl -i http://localhost:3000/corpus/details.json
```

Response:
```json
HTTP/1.1 200 OK
...
{
  "corpus":{
    "count":3,
    "lengths":{
      "min":4,
      "max":4,
      "avg":4.0,
      "median":4
    }
  }
}
```

#### DELETE /words/:word.json
**Description:** Deletes single word

Request:
```shell
curl -i -X DELETE http://localhost:3000/words/read.json
```

Response:
```json
HTTP/1.1 200 OK
...
```

#### DELETE /words.json
**Description:** Deletes all words in corpus
Request:
```shell
curl -i -X DELETE http://localhost:3000/words.json
```

Response:
```json
HTTP/1.1 204 No Content
...
```

## Encountered edge cases
1. `POST /words.json` always returns a 201, but it shouldn't if all words in the request are rejected
2. Anagram.rb is case insensitive, so Green and green are considered unique. We may want to change it; worth considering
3. `GET /corpus/details.json` throws an error if the corpus is empty

## Future features
Following, are things to consider:

**Foundation**
1. A script to process dictionary.txt into a base corpus
2. A key-value database, instead of SQL, to store words on sorted-word keys (reverse index style)
3. A search indexer like Elasticsearch in addition to an SQL database to speed up search and mimic key/value store idea above
4. An endpoint to add words to the dictionary and a faster data store for the dictionary
5. Authorization protecting at least:
  * `DELETE /words/:word.json`
  * `DELETE /words.json` and consider authorization for `POST /words.json`

**Request/Response**
1. `GET /anagrams/:word.json`
  * Paging for  response
  * Default limit for the number of anagrams returned
2. `POST /words.json`
  * Default limit for how many words can be submitted per request 
  * Error messages for rejected words
  
**Documentation**
1. Pick an API versioning scheme for making non-breaking improvements/changes.
2. A service like [Apiary](http://apiary.io) to host and help with API design and endpoint documentation.
