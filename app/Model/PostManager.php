<?php
namespace App\Model;
use Nette;
/**
 * Users management.
 */
class PostManager
{
	//use Nette\SmartObject;
	const
		TABLE_NAME = 'posts',
		COLUMN_ID = 'id',
		COLUMN_TITLE = 'title',
		COLUMN_CONTENT = 'content',
		COLUMN_CREATED_AT = 'created_at';

	/** @var Nette\Database\Context */
	private $database;
	public function __construct(Nette\Database\Context $database)
	{
	    $this->database = $database;
	}
	/**
	 * Get latest news.
         * @param integer
	 * @return ActiveRow
	 */
	public function getLatest($limit, $offset)
	{
            return $this->database->table(self::TABLE_NAME)->order(self::COLUMN_CREATED_AT.' DESC')->limit($limit, $offset)->fetchAll();
	}
        /**
	 * Get latest news.
         * @param integer
	 * @return ActiveRow
	 */
	public function getById($id)
	{
            return $this->database->table(self::TABLE_NAME)->where('id = ?', $id)->fetch();
	}        
        /**
	 * Get latest news.
         * @param integer
	 * @return ActiveRow
	 */
	public function getByCategory($category)
	{
            return $this->database->table(self::TABLE_NAME)->where('category = ?', $category)->order(self::COLUMN_CREATED_AT.' DESC')->fetchAll();
	}
        /**
	 * Get latest news.
         * @param integer
	 * @return ActiveRow
	 */
	public function getCategoryByYear($category)
	{
	    return $this->database->table(self::TABLE_NAME)->select('*, YEAR('.self::COLUMN_CREATED_AT.') AS year')->where('category = ?', $category)->order(self::COLUMN_CREATED_AT.' DESC')->fetchAll();
	}        
        /**
	 * Get latest news.
         * @param integer
	 * @return ActiveRow
	 */
	public function getAll()
	{
            return $this->database->table(self::TABLE_NAME)->fetchAll();
	}        
        
        public function getCommentaries($user_id) {
            return $this->database->table('comments')->where('user_id', $user_id)->order('created_at DESC')->fetchAll();
        }
        public function insert($values) {
            $this->database->table(self::TABLE_NAME)->insert($values);
        }
        
        public function update($id, $values) {
            $this->database->table(self::TABLE_NAME)->where(self::COLUMN_ID, $id)->update($values);
        }
        public function updateStars($id, $stars) {
            $this->database->table(self::TABLE_NAME)->where(self::COLUMN_ID, $id)->update(['stars'=>$stars]);
        }
        
        public function delete($id) {
            $this->database->table(self::TABLE_NAME)->where(self::COLUMN_ID, $id)->delete();
        }
        
        public function addComment($values) {
            $this->database->table('comments')->insert($values);
        }
        
        public function deleteComment($id) {
            $this->database->table('comments')->where('id', $id)->delete();
        }        
}