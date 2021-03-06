<script type="text/javascript">
    jQuery(document).ready(function($){
        {foreach from=$aComments item=oComment}
            $("#comment_id_{$oComment->getId()}").css("padding", "15px 10px 15px 68px");
            {if $oComment->getDelete() and $oUserCurrent and !$oUserCurrent->isAdministrator()}
                {assign var="oUser" value=$oComment->getUser()}
                $("#comment_id_{$oComment->getId()}").html('<a name="comment{$oComment->getId()}"></a>\
\
\
		<a class="circle" href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" alt="avatar" class="comment-avatar" /></a>\
\
\
		<ul class="comment-info">\
			<li class="comment-author {if $iAuthorId == $oUser->getId()}comment-topic-author" title="{if $sAuthorNotice}{$sAuthorNotice}{/if}{/if}">\
				<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>\
			</li>\
			<li class="comment-date">\
				<a href="{if $oConfig->GetValue('module.comment.nested_per_page')}{router page='comments'}{else}#comment{/if}{$oComment->getId()}" class="link-dotted" title="{$aLang.comment_url_notice}">\
					<time datetime="{date_format date=$oComment->getDate() format='c'}">{date_format date=$oComment->getDate() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}</time>\
				</a>\
			</li>\
\
			{if $oComment->getPid()}\
				<li class="goto-comment-parent"><a href="#" onclick="ls.comments.goToParentComment({$oComment->getId()},{$oComment->getPid()}); return false;" title="{$aLang.comment_goto_parent}">↑</a></li>\
			{/if}\
			<li class="goto-comment-child"><a href="#" title="{$aLang.comment_goto_child}">↓</a></li>\
\
\
			{if $oComment->getTargetType() != 'talk'}\
				<li id="vote_area_comment_{$oComment->getId()}" class="vote \
																		{if $oComment->getRating() > 0}\
																			vote-count-positive\
																		{elseif $oComment->getRating() < 0}\
																			vote-count-negative\
																		{/if}\
\
																		{if $oVote}\
																			voted\
\
																			{if $oVote->getDirection() > 0}\
																				voted-up\
																			{else}\
																				voted-down\
																			{/if}\
																		{/if}">\
					<div class="vote-up" onclick="return ls.vote.vote({$oComment->getId()},this,1,\'comment\');"></div>\
					<span class="vote-count" id="vote_total_comment_{$oComment->getId()}">{if $oComment->getRating() > 0}+{/if}{$oComment->getRating()}</span>\
					<div class="vote-down" onclick="return ls.vote.vote({$oComment->getId()},this,-1,\'comment\');"></div>\
				</li>\
			{/if}\
\
\
			{if $oUserCurrent and !$bNoCommentFavourites}\
				<li class="comment-favourite">\
					<div onclick="return ls.favourite.toggle({$oComment->getId()},this,\'comment\');" class="favourite {if $oComment->getIsFavourite()}active{/if}"></div>\
					<span class="favourite-count" id="fav_count_comment_{$oComment->getId()}">{if $oComment->getCountFavourite() > 0}{$oComment->getCountFavourite()}{/if}</span>\
				</li>\
			{/if}\
		</ul>\
\
\
		<div id="comment_content_id_{$oComment->getId()}" class="comment-content text">\
			{$oComment->getText()}\
		</div>\
\
\
			<ul class="comment-actions">\
                {if !$oConfig->GetValue('plugin.deletecomment.use_limit_time') || (strtotime($oComment->getDate()) > $smarty.now - $oConfig->GetValue('plugin.deletecomment.limit_time'))}\
					<li><a href="#" class="comment-repair link-dotted" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_repair}</a></li>\
                {/if}\
			</ul>');
            {/if}
        {/foreach}
    });
</script>
