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

$config = array();

// Использовать ограничение рейтинга для удаления/восстановления комментариев
$config['use_limit_rating'] = true;

// Порог рейтинга при котором юзер может удалять/восстанавливать комментарии
// (используется при $config['use_limit_rating'] = true).
$config['limit_rating'] = 0;

return $config;
?>