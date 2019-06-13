<?php

declare(strict_types = 1);

namespace App\Presenters;

use Nette;
use Nette\Application\UI\Form;
use App\Model\PostManager;

//
//
/// Je třeba upravit formuláře a funkce pro práci s databazí pro využití modelu
//
///
//
class PostPresenter extends Nette\Application\UI\Presenter {

    /** @var Nette\Database\Context */
    private $database1;
    private $database;
    private $postManager;

    public function __construct(Nette\Database\Context $database, PostManager $postManager) {
        $this->database1 = $database;
        $this->database = $postManager;
        $this->postManager = $postManager;
    }

    public function renderShow(int $postId) {
        $post = $this->database->getById($postId);

        if (!$post) {
            $this->error('Stránka nebyla nalezena');
        }

        $this->template->post = $post;
        $this->template->comments = $post->related('comment')->order('created_at');
    }

    protected function createComponentCommentForm(): Form {
        $form = new Form; // means Nette\Application\UI\Form

        $form->addText('name', 'Jméno:')
                ->setRequired();

        $form->addTextArea('content', 'Komentář:')
                ->setRequired();

        $form->addSubmit('send', 'Publikovat komentář');
        $form->onSuccess[] = [$this, 'commentFormSucceeded'];
        return $form;
    }

    // Zkontrolovat možné použití Manageru
    public function commentFormSucceeded(Form $form, \stdClass $values): void {
        $postId = $this->getParameter('postId');

        $this->database1->table('comments')->insert([
            'post_id' => $postId,
            'name' => $values->name,
            'email' => $values->email,
            'content' => $values->content,
        ]);

        $this->flashMessage('Děkuji za komentář', 'success');
        $this->redirect('this');
    }

    protected function createComponentPostForm(): Form {
        $form = new Form;
        $form->addText('title', 'Titulek:')
                ->setRequired();
        $form->addTextArea('content', 'Obsah:')
                ->setRequired();

        $form->addSubmit('send', 'Uložit a publikovat');
        $form->onSuccess[] = [$this, 'postFormSucceeded'];

        return $form;
    }

    public function postFormSucceeded(Form $form, \stdClass $values): void {
        if (!$this->getUser()->isLoggedIn()) {
        $this->error('Pro vytvoření, nebo editování příspěvku se musíte přihlásit.');
    }
        $postId = $this->getParameter('postId');

        if ($postId) {
            $this->postManager->updatePost($postId, $values);
            //$post = $this->database->getById($postId);
            //$post->update($values);
        } else {
            $post = $this->database->insertPost($values);
        }

        $this->flashMessage('Příspěvek byl úspěšně publikován.', 'success');
        //$this->redirect('show', $post->id);
        $this->redirect('Homepage:default');
    }

    public function actionEdit($id): void {
        if (!$this->getUser()->isLoggedIn()) {
            $this->redirect('Sign:in');
             }
            $post = $this->database1->table('posts')->get($id);
            if (!$post) {
                $this->error('Příspěvek nebyl nalezen');
            }
            $this['postForm']->setDefaults($post->toArray());
       
    }

    public function actionCreate(): void {
        if (!$this->getUser()->isLoggedIn()) {
            $this->redirect('Sign:in');
        }
    }
    
    public function actionDelete($id){
        $this->postManager->delete($id);
        $this->flashMessage('Příspěvek byl smazán.');
        $this->redirect('Homepage:default');
        
    }
    

}
