module ApplicationHelper
  def follow!(other_user)
      relationships.create!(followed_id: other_user)
  end

  def unfollow!(other_user)
      relationships.find_by_followed_id(other_user.id).destroy
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('👎', post_like_path(id: like.id, post_id: post.id), method: :delete, class: 'likes')
    else
      link_to('👍', post_likes_path(post_id: post.id), method: :post, class: 'likes')
    end
  end

  def flash_notice
    return unless flash[:notice]

    raw("<div class='notification is-primary global-notification mb-0'>
            <p class='notice'>#{notice}</p>
            </div>")
  end
    
  def flash_alert
    return unless flash[:alert]

    raw("<div class='notification is-danger global-notification mb-0'>
            <p class='alert'>#{alert}</p>
        </div>")
  end

  def side_panel_on
    return unless signed_in?

    raw("<div class='is-flex h-100 '>
            <div class='side-panel px-2 py-2'>
                #{render 'users/side_panel'}
            </div>")
  end
    
end
