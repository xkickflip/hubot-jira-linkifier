# hubot-jira-linkifier

Hubot listens for a list of your JIRA project prefixes like "DEV-123" and responds with full clickable links to the tickets. It specifically does not connect to Jira's API and just builds the link so that it responds as quickly as possible.

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

Now setup the two environment variables to provide the needed information to find and build the ticket links:

```
export HUBOT_JIRA_LINKIFIER_PROJECT_PREFIXES="DEV,OPS,QA"
export HUBOT_JIRA_LINKIFIER_JIRA_URL="https://jira.mydomain.com"
```

## Sample Interaction
Hubot will listen for all occurences (case insensitive) of possible tickets in a message and respond with a link for each it encounters:

```
user1>> Hey I created a new ticket DEV-666 and a related one OPS-777
hubot>> https://jira.mydomain.com/browse/DEV-666
hubot>> https://jira.mydomain.com/browse/OPS-777
```
