<?php

declare(strict_types=1);

namespace App\Presenters;

use Nette;
use App\Model\PostManager;
use Nette\Security\Identity;


class HomepagePresenter extends Nette\Application\UI\Presenter
{
    /** @var Nette\Database\Context */
    
    private $postManager;
    //private $user;

    public function __construct(PostManager $postManager)
    {
        $this->postManager = $postManager;
        //$this->user = $user;
    }

    // ...
    
    public function renderDefault()
{
    $this->template->posts = $this->postManager->getAll('created_at');
}
    
}