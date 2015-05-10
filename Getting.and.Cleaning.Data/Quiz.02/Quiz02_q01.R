library(httr)
library(httpuv)
require(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", key="691273d4c879806064a6", secret="40c2c5d7f128225091feafd68c2822dc8f384d03")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)

# request the webpage from the URL
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# extract out the content from the request
json1 = content(req)

# convert the list to json
json2 = jsonlite::fromJSON(toJSON(json1))

# check the names within the object
names(json2)

# "full_name" is the the relevant field
ans <- json2[which(json2$full_name == "jtleek/datasharing"),]$created_at

