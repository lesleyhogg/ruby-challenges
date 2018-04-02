class Blog
  @@all_blog_posts = []
  @@num_blog_posts = 0

  def self.all
    @@all_blog_posts
  end
  def self.add(blogpost)
    @@all_blog_posts << blogpost
    @@num_blog_posts += 1
  end
  def self.publish
    @@all_blog_posts.each do |post|
      puts "Title:\n #{post.title}"
      puts "Body:\n #{post.content}"
      puts "Published:\n #{post.pubdate}"
    end
  end
end

class BlogPost < Blog
  attr_accessor :title, :content, :pubdate
  def self.create
    post = new
    puts "Name your blog post:"
    post.title = gets.chomp
    puts "Your blog post content:"
    post.content = gets.chomp
    post.pubdate = Time.now
    post.save
    puts "Do you want to create another post? y/n"
    create if gets.chomp.downcase == 'y'
  end
  def save
    BlogPost.add(self)
  end
end

BlogPost.create
all_blog_posts = BlogPost.all
puts all_blog_posts.inspect
BlogPost.publish
