# Check-in

A random question displayed in a nice green setting. Done.

Visit https://damp-thicket-68463.herokuapp.com/ for an example.

Use `/today` for a question that is fixed to the current day.

Try `/!/10` or any other number below 17 to find a fixed question
for sharing on social media.

If you want a JSON reply, just ask for it:

```
curl -i -H "Accept: application/json" https://damp-thicket-68463.herokuapp.com/
```

Add "?lang=(en|de|nl)" to your query in order to get a check-in question
in the language of your choice, both in JSON and web

## API description

* `/today(?lang=:lang)` - the question for today
* `/questions(?lang=:lang)` - a list of all available questions
* `/!/:id(?lang=:lang)` - a specific question, index 1
* `/!(?lang=:lang)` - a random question
* `/languages(?lang=:lang)` - a list of available languages

All answers in JSON.

Default language if none provided: English 🏴󠁧󠁢󠁥󠁮󠁧󠁿.

## TODO

Change the RESTful-urls to put the required language up front, like so:
* `/:lang/!/10``
* `/:lang/today`
