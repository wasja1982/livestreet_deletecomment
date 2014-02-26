<script type="text/javascript">
    jQuery(document).ready(function($){
        {foreach from=$aComments item=oComment}
            $("#comment_id_{$oComment->getId()}");
            {if $oComment->getDelete() and $oUserCurrent and !$oUserCurrent->isAdministrator()}
                {assign var="oUser" value=$oComment->getUser()}
                $("#comment_id_{$oComment->getId()}").html('<a name="comment{$oComment->getId()}"></a>\
\
		<div class="folding"></div>\
\
		<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" alt="avatar" class="comment-avatar avatar" /></a>\
\
\
        {if $iAuthorId == $oUser->getId()}\
		<a href="{$oUser->getUserWebPath()}"><span class="comment-topic-author" title="{if $sAuthorNotice}{$sAuthorNotice}{/if}"></span>\
		</a>\
		{/if}\
\
\
		<ul class="comment-info">\
			<li class="comment-author {if $iAuthorId == $oUser->getId()}active{/if}">\
					{if $oUser->getProfileName()}\
					<a href="{$oUser->getUserWebPath()}">{$oUser->getProfileName()}</a>\
					{else}\
					<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>\
					{/if}\
			</li>\
			<li>\
			<span class="bullet">•</span>\
			</li>\
			<li class="comment-date">\
				<time datetime="{date_format date=$oComment->getDate() format='c'}" title="{date_format date=$oComment->getDate() format="j F Y, H:i"}">\
					{date_format date=$oComment->getDate() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}\
				</time>\
			</li>\
\
\
			{if $oComment->getPid()}\
				<li class="goto-comment-parent"><a href="#" onclick="ls.comments.goToParentComment({$oComment->getId()},{$oComment->getPid()}); return false;" title="{$aLang.comment_goto_parent}"></a>\
				</li>\
			{/if}\
				<li class="goto-comment-child"><a href="#" title="{$aLang.comment_goto_child}"></a>\
				</li>\
		</ul>\
\
\
			<div id="comment_content_id_{$oComment->getId()}" class="comment-content text">\
				{$oComment->getText()}\
			</div>\
\
\
		<ul class="info_comment_ul">\
\
\
<li>\
<a href="#" onclick="ls.comments.toggleCommentForm({$oComment->getId()}); return false;" class="reply-link">{$aLang.comment_answer}</a>\
</li>\
\
\
			{if $oUserCurrent and !$bNoCommentFavourites}\
				<li class="comment-favourite\
				{if $oComment->getCountFavourite() > 0}\
				has-favs\
				{/if}">\
					<a href="#" onclick="return ls.favourite.toggle({$oComment->getId()},this,\'comment\');" class="favourite_com\
					{if $oComment->getIsFavourite()}\
					active\
					{/if}">\
					</a>\
					<span class="favourite-count_new" id="fav_count_comment_{$oComment->getId()}">{if $oComment->getCountFavourite() > 0}&nbsp;{$oComment->getCountFavourite()}\
					{else}\
					{/if}\
					</span>\
				</li>\
			{/if}\
\
\
			{if $oComment->getTargetType() != 'talk'}\
				<div style="float:left;" id="vote_area_comment_{$oComment->getId()}" class="vote_new\
																		{if $oComment->getRating() > 0}\
																			vote-count-positive\
																		{elseif $oComment->getRating() < 0}\
																			vote-count-negative\
																		{elseif $oComment->getRating() == 0}\
																		vote-count-zero\
																		{/if}\
\
																		{if (strtotime($oComment->getDate()) < $smarty.now - $oConfig->GetValue('acl.vote.comment.limit_time') && !$oVote) || ($oUserCurrent && $oUserCurrent->getId() == $oUser->getId())}\
																			vote-expired\
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
					<div class="plagin_class" onclick="return ls.vote.vote({$oComment->getId()},this,1,\'comment\');">{$aLang.topic_vote_up_new}</div>\
					<span class="vote-count_new" id="vote_total_comment_{$oComment->getId()}">{if $oComment->getRating() > 0}+{/if}{$oComment->getRating()}</span>\
					<div class="vote-down_new plagin_class" onclick="return ls.vote.vote({$oComment->getId()},this,-1,\'comment\');">{$aLang.topic_vote_down_new}</div>\
				</div>\
			{/if}\
\
\
			<li class="comment-link">\
				<a href="{if $oConfig->GetValue('module.comment.nested_per_page')}{router page='comments'}{else}#comment{/if}{$oComment->getId()}" title="{$aLang.comment_url_notice}">\
				</a>\
			</li>\
\
                {if !$oConfig->GetValue('plugin.deletecomment.use_limit_time') || (strtotime($oComment->getDate()) > $smarty.now - $oConfig->GetValue('plugin.deletecomment.limit_time'))}\
					<li><a href="#" class="comment-repair link-dotted" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_repair}</a></li>\
                {/if}\
		</ul>');
            {/if}
        {/foreach}
    });
</script>