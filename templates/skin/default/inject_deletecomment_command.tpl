{if !$oComment->getDelete() and $oUserCurrent and !$oUserCurrent->isAdministrator()}
    <li><a href="#" class="comment-delete link-dotted" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_delete}</a></li>
{/if}
<script type="text/javascript">
    jQuery(document).ready(function($){
        $("#comment_id_{$oComment->getId()}").css("padding", "10px 0 0 40px");
    });
</script>
