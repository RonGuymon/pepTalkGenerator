# pepTalkGenerator

Getting this from a simple set of code to an api on an AWS server took some learning. The plumber package makes it easy to turn code into an api, but getting it into Docker and then onto AWS was tricky. I'll do my best to outline the steps.

1. Create a script in R and make sure it works.
2. Turn it into a plumber file by using the plumber package.
