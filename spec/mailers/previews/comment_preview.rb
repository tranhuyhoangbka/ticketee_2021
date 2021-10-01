# Preview all emails at http://localhost:3000/rails/mailers/comment
class CommentPreview < ActionMailer::Preview
  def new_comment
    project = Project.new(id: 1, name: 'Example project')
    ticket = project.tickets.build(id: 1, name: 'Example ticket')
    user = User.new(email: 'user@sample.com')
    comment = ticket.comments.build(author: user, text: 'Hello threee')
    CommentMailer.with(comment: comment, user: comment.author).new_comment
  end
end
