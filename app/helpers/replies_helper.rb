module RepliesHelper
    def delete_reply(reply)
        return unless current_user?(reply.user)
    
        link_to post_reply_path(:post_id, reply.id), method: :delete,
                                                       data: { confirm: 'Are you sure you want to delete this post?' } do
          raw(" <span class='icon'>
                            <i class='fa fa-trash-o' aria-hidden='true'></i>
                        </span>")
        end
      end
end
