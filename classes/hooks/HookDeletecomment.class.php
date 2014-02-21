<?php
/**
 * Delete Comment - удаление любых комментариев в своих топиках
 *
 * Версия:	1.0.0
 * Автор:	Александр Вереник
 * Профиль:	http://livestreet.ru/profile/Wasja/
 * GitHub:	https://github.com/wasja1982/livestreet_deletecomment
 *
 **/

class PluginDeletecomment_HookDeletecomment extends Hook {
    public function RegisterHook() {
        $bUseLimitRating = Config::Get('plugin.deletecomment.use_limit_rating');
        $iLimitRating = Config::Get('plugin.deletecomment.limit_rating');
        $oUserCurrent=$this->User_GetUserCurrent();
        if (!$oUserCurrent || $oUserCurrent->isAdministrator() || ($bUseLimitRating && $oUserCurrent->getRating() < $iLimitRating)) {
            return;
        }
        $this->AddHook('template_comment_action', 'InjectDeleteLink');
        $this->AddHook('template_comment_tree_end', 'InjectDeleteTree');
    }

    public function InjectDeleteLink($aParam) {
        $oUserCurrent=$this->User_GetUserCurrent();
        if (!$oUserCurrent || $oUserCurrent->isAdministrator()) {
            return;
        }
        $oComment = $aParam['comment'];
        if (!$oComment || $oComment->getTargetType()!='topic' || !$oComment->getTarget() || $oComment->getTarget()->getUserId()!=$oUserCurrent->getId()) {
            return;
        }

        $sTemplatePath = Plugin::GetTemplatePath(__CLASS__) . 'inject_deletecomment_command.tpl';
        if ($this->Viewer_TemplateExists($sTemplatePath)) {
            $this->Viewer_Assign('oComment', $oComment);
            return $this->Viewer_Fetch($sTemplatePath);
        }
    }

    public function InjectDeleteTree($aParam) {
        $oUserCurrent=$this->User_GetUserCurrent();
        if (!$oUserCurrent || $oUserCurrent->isAdministrator()) {
            return;
        }
        if ($aParam['sTargetType'] != 'topic') {
            return;
        }
        $oTopic = $this->Topic_GetTopicById($aParam['iTargetId']);
        if (!$oTopic || $oTopic->getUserId()!=$oUserCurrent->getId()) {
            return;
        }
        $sTemplatePath = Plugin::GetTemplatePath(__CLASS__) . 'inject_deletecomment_tree.tpl';
        if ($this->Viewer_TemplateExists($sTemplatePath)) {
            $this->Viewer_Assign('iAuthorId', $oTopic->getUserId());
            $this->Viewer_Assign('sAuthorNotice', $this->Lang_Get('topic_author'));
            return $this->Viewer_Fetch($sTemplatePath);
        }
    }
}
?>