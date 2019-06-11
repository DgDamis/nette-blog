<?php

declare(strict_types=1);

namespace App\Presenters;

use Nette;
use App\Model\PostManager;


class HomepagePresenter extends Nette\Application\UI\Presenter
{
    /** @var Nette\Database\Context */
    
    private $postManager;

    public function __construct(PostManager $postManager)
    {
        $this->postManager = $postManager;
    }

    // ...
    
    public function renderDefault()
{
    $this->template->posts = $this->postManager->getAll();  
}
}