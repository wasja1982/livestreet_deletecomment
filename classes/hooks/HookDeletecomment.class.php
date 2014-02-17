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
        if (!$this->User_GetUserCurrent()) {
            return;
        }
        $this->AddHook('template_comment_action', 'InjectDeleteLink');
    }

    public function InjectDeleteLink($aParam)
    {
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
}
?>