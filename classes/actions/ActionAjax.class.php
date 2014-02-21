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

class PluginDeletecomment_ActionAjax extends PluginDeletecomment_Inherit_ActionAjax {
    /**
     * Удаление/восстановление комментария
     *
     */
    protected function EventCommentDelete() {
        /**
         * Есть права на удаление комментария?
         */
        if ($this->ACL_CanDeleteComment($this->oUserCurrent)) {
            return parent::EventCommentDelete();
        } else {
            $bUseLimitRating = Config::Get('plugin.deletecomment.use_limit_rating');
            $iLimitRating = Config::Get('plugin.deletecomment.limit_rating');
            if (!$this->oUserCurrent || ($bUseLimitRating && $this->oUserCurrent->getRating() < $iLimitRating)) {
                $this->Message_AddErrorSingle($this->Lang_Get('not_access'),$this->Lang_Get('error'));
                return;
            }
            /**
             * Комментарий существует?
             */
            $idComment=getRequestStr('idComment',null,'post');
            if (!($oComment=$this->Comment_GetCommentById($idComment))) {
                $this->Message_AddErrorSingle($this->Lang_Get('system_error'),$this->Lang_Get('error'));
                return;
            }
            if ($oComment->getTargetType()!='topic' || !$oComment->getTarget() || $oComment->getTarget()->getUserId()!=$this->oUserCurrent->getId()) {
                $this->Message_AddErrorSingle($this->Lang_Get('not_access'),$this->Lang_Get('error'));
                return;
            }
            /**
             * Устанавливаем пометку о том, что комментарий удален
             */
            $oComment->setDelete(($oComment->getDelete()+1)%2);
            $this->Hook_Run('comment_delete_before', array('oComment'=>$oComment));
            if (!$this->Comment_UpdateCommentStatus($oComment)) {
                $this->Message_AddErrorSingle($this->Lang_Get('system_error'),$this->Lang_Get('error'));
                return;
            }
            $this->Hook_Run('comment_delete_after', array('oComment'=>$oComment));
            /**
             * Формируем текст ответа
             */
            if ($bState=(bool)$oComment->getDelete()) {
                $sMsg=$this->Lang_Get('comment_delete_ok');
                $sTextToggle=$this->Lang_Get('comment_repair');
            } else {
                $sMsg=$this->Lang_Get('comment_repair_ok');
                $sTextToggle=$this->Lang_Get('comment_delete');
            }
            /**
             * Обновление события в ленте активности
             */
            $this->Stream_write($oComment->getUserId(), 'add_comment', $oComment->getId(), !$oComment->getDelete());
            /**
             * Показываем сообщение и передаем переменные в ajax ответ
             */
            $this->Message_AddNoticeSingle($sMsg,$this->Lang_Get('attention'));
            $this->Viewer_AssignAjax('bState',$bState);
            $this->Viewer_AssignAjax('sTextToggle',$sTextToggle);
        }
    }
}
?>