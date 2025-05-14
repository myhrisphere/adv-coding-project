;;; Part I: Bubble sort with +1 for odd numbers
;;; ------------------------------

(defun generate-list ()
  "Generates a list of 100 random integers from 0 to 99."
  (loop repeat 100 collect (random 100)))

(defun adjust-odds (lst)
  "Increments all odd numbers by 1 in the list."
  (mapcar (lambda (x) (if (oddp x) (+ x 1) x)) lst))

(defun bubble-sort-desc (lst)
  "Sorts the list in descending order using bubble sort."
  (let ((copy (copy-list lst)))
    (dotimes (i (length copy) copy)
      (dotimes (j (- (length copy) (1+ i)))
        (when (< (nth j copy) (nth (1+ j) copy))
          (rotatef (nth j copy) (nth (1+ j) copy)))))))

(defun run-part1 ()
  (let* ((original (generate-list))
         (adjusted (adjust-odds original))
         (sorted (bubble-sort-desc adjusted)))
    (format t "Original list: ~a~%" original)
    (format t "Adjusted list: ~a~%" adjusted)
    (format t "Sorted list: ~a~%" sorted)))

(run-part1)

;;; Part II: Merge Sort with recursion (renamed)
;;; ------------------------------
(defun my-merge (left right)
  "Merges two sorted lists into one sorted list (descending order)."
  (cond
    ((null left) right)
    ((null right) left)
    ((>= (first left) (first right))
     (cons (first left) (my-merge (rest left) right)))
    (t
     (cons (first right) (my-merge left (rest right))))))

(defun merge-sort (lst)
  "Recursively sorts the list in descending order using merge sort."
  (if (<= (length lst) 1)
      lst
      (let* ((mid (floor (/ (length lst) 2)))
             (left (subseq lst 0 mid))
             (right (subseq lst mid)))
        (my-merge (merge-sort left) (merge-sort right)))))

(defun run-part2 ()
  (let ((lst (adjust-odds (generate-list))))
    (format t "Merge sorted list: ~a~%" (merge-sort lst))))

(run-part2)
