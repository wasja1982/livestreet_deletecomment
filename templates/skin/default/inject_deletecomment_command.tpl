{if !$oComment->getDelete() and $oUserCurrent and !$oUserCurrent->isAdministrator()}
    <li><a href="#" class="comment-delete link-dotted" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_delete}</a></li>
{/if}