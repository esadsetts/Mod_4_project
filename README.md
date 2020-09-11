# Pay Attention to this Bag of Tweets!

### Eryk Wdowiak and Eric Adsetts

This project explores the many different ways that we can use the tools of Natural Language Processing to detect sentiment in a string of text, specifically [Tweets directed at Google and Apple products](https://data.world/crowdflower/brands-and-product-emotions/).

Below we show that "Bag of Words" methods can help us understand text in this particular dataset, but they are domain specific.  They cannot help us understand text from other datasets.  By contrast, word embeddings, like the [GloVe](https://nlp.stanford.edu/projects/glove/) and [word2vec](https://en.wikipedia.org/wiki/Word2vec) models, represent semantic meaning in a multidimensional space.  So in theory, word embeddings should help us find meaning across datasets.

In practice however, word embeddings suffer from a lack of "stationarity" -- a word's relationship with other words changes over time and over domain.  Consequently, word embeddings are only useful when working with datasets that are similar in time and in domain to the text that the embeddings were trained on.

For example, [Honnibal and Montani (2019)](https://explosion.ai/blog/sense2vec-reloaded) trained word embeddings on [reddit](https://www.reddit.com/) comments from 2015 and 2019 and created a [demonstration page](https://explosion.ai/demos/sense2vec) where you can see how word associations changed in just four years.

If we had stationary word embeddings, we could directly detect sentiment from what the user wrote instead of indirectly detecting sentiment from keywords that were correlated with that sentiment at the time and in the domain that the keywords were written.  For example, the sentence embeddings that [Lin, Feng, et al. (2017)](https://arxiv.org/abs/1703.03130) developed build on word embeddings.  So their sentence embeddings can find the semantic meaning of a whole sentence if the relationship among words is stationary.

Regrettably, the Tweets in our dataset come from a very different English language than the English language commonly used to train word embeddings, so we ask you please to "pay attention to this bag of tweets" because the self-attentional sentence embeddings that we explore below do not predict sentiment as well as bag of words methods.


### Bag of Words Methods

The good news is that "bag of words" methods are particularly effective at predicting a tweet's sentiment.

By removing punctuation and stopwords and by converting words back to their lemma, we reduce the vocabulary of the tweets.  Counts of the remaining words then forms the basis of a term-document matrix.  Then, using a term-frequency, we can then measure the importance of a word by how often it appears within a document.  And using inverse document frequency, we can measure the importance of a word by how infrequently it appears across documents.

The product of those two measures (term frequency and inverse document frequency) allows words to be used as explanatory variables in a statistical model.  Here, we created classifiers via Naive Bayes, Random Forest, Logistic Regression, Decision Tree, K-Nearest Neighbors and Support Vector Machine and all of them yielded F1 scores over 0.60.

So we can conclude that "bag of words" methods make good predictions, but they're limited to a specific time and domain.


### Sentence Embeddings

As an alternative, we attempted to train self-attentive sentence embeddings, like the ones that [Lin, Feng, et al.](https://arxiv.org/abs/1703.03130) trained, by following [Gluon's tutorial](https://gluon-nlp.mxnet.io/examples/sentence_embedding/self_attentive_sentence_embedding.html).

Their method is attractive because (unlike "bag of words" methods) it classifies text based on semantic meaning and also because the "attention" layers identify the words that the model focused on when predicting the classification.  Effectively, it yields both a classification and a reason for that classification.

Intuitively, one might classify a Tweet based on a particular set of words within it.  Those words have a particular semantic meaning that serves as the basis for the Tweet's classification.  Lin, Feng, et al.'s model captures both.  Their model's self-attentive layers identify the important words, while a reference word embedding model captures the semantic meaning, so that the Tweet can be classified.

At the present time however, we could not use their method to develop a reliable predictor of sentiment because the text used to train the [GloVe](https://nlp.stanford.edu/projects/glove/) embeddings is very different from the tweets that users directed at Google and Apple products.

Nonetheless, if the relationships among words were stationary, we could use this method to classify and understand the classification.

### Conclusion

But perhaps it's natural for words to change meaning over time.  If so, then the theoretical advantages of word embeddings are just an illusion.  We should just "pay attention to this bag of tweets."


### Sources Cited

* J. Pennington, R. Socher, C. Manning (2014). "[GloVe: Global Vectors for Word Representation](https://nlp.stanford.edu/projects/glove/)."
* Z. Lin, M. Feng, et al. (2017). "A Structured Self-Attentive Sentence Embedding." [arXiv: 1703.03130](https://arxiv.org/abs/1703.03130)
* Gluon. "Structured Self-Attentive Sentence Embedding." [Gluon NLP Tutorials](https://gluon-nlp.mxnet.io/examples/sentence_embedding/self_attentive_sentence_embedding.html)
* M. Honnibal and I. Montani (21 Nov 2019). "sense2vec Reloaded: Contextually-Keyed Word Vectors." [explosion.ai](https://explosion.ai/blog/sense2vec-reloaded)




