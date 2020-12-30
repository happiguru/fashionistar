module PostsHelper
    def custom_timeline
        friends = current_user.followed_users
        friends_posts = []
        if friends.empty?
          friends_posts = current_user.posts
        else
          friends.each do |friend|
            user_finder = User.find(friend.id)
            friends_posts = user_finder.posts + current_user.posts
          end
        end
        friends
    end
    
      def edit_delete_own_post
        return unless current_user?(@post.user)
    
        link_to edit_post_path(@post), class: 'level-item' do
          raw("  <span class='icon'>
                <i class='fa fa-pencil' aria-hidden='true'></i>
            </span>")
        end
    
        link_to @post, method: :delete, data: { confirm: 'Are you sure you want to delete this post?' },
                        class: 'level-item' do
          raw("  <span class='icon'>
                <i class='fa fa-trash-o' aria-hidden='true'></i>
            </span>")
        end
      end
    
      def delete_own_post(post)
        return unless current_user == post.user
    
        link_to post, method: :delete, data: { confirm: 'Are you sure you want to delete this post?' },
                       class: 'level-item delet' do
          raw("<span class='icon'>
                <i class='fa fa-trash-o'  aria-hidden='true'></i>
            </span>")
        end
      end
end
