# hubot-jira-linkifier

Hubot listens for a list of your JIRA project codes and responds with full clickable links to the tickets.

See [`src/jira-linkifier.coffee`](src/jira-linkifier.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-jira-linkifier --save`

Then add **hubot-jira-linkifier** to your `external-scripts.json`:

```json
[
  "hubot-jira-linkifier"
]
```

## Sample Interaction

```
user1>> hubot hello
hubot>> hello!
```
