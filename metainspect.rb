# Returns the document author
def best_author
  @best_author ||= find_best_author
end

# An author getter that returns the first non-nil description
# from the following candidates:
# - the standard meta description
# - a link with the relational attribute "author"
# - address tag which may contain the author
# - the twitter:creator meta tag for the username
def find_best_author
  candidates = [
    meta['author'],
    parsed.css('a[rel="author"]').first,
    parsed.css('address').first,
    meta['twitter:creator']
  ]
  candidates.find { |x| !x.to_s.empty? }
end
