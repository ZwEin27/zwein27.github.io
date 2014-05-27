#
# post_footer_filter.rb
# Append every post some footer infomation like original url 
# Kevin Lynx
# 7.26.2012
#

require './plugins/post_filters'

module AppendFooterFilter
  def append(post)
     author = post.site.config['author']
     url = post.site.config['url']
     pre = post.site.config['original_url_pre']
     #post.content + %Q[<p class='post-footer'>#{pre or "original link:"}<a href='#{post.full_url}'>#{post.full_url}</a><br/>&nbsp;Written by <a href='#{url}'>#{author}</a>&nbsp;posted at <a href='#{url}'>#{url}</a></p>]
     #post.content + %Q[<p class='post-footer'>Copyright ©#{author} | Original Link：<a href='#{post.full_url}'>#{title}</a><br/>&nbsp;Written by <a href='#{url}'>#{author}</a>&nbsp;posted at <a href='#{url}'>#{url}</a></p>]
     post.content + %Q[<p class='post-footer'>版权所有 ©#{author} | 转载请注明出处：<a href='#{post.full_url}'>#{post.full_url}</a></p>]
        
  end 
end

module Jekyll
  class AppendFooter < PostFilter
    include AppendFooterFilter
    def pre_render(post)
      post.content = append(post) if post.is_post?
    end
  end
end

Liquid::Template.register_filter AppendFooterFilter
