Table Photos as P {
  photo_id int [pk, increment]
  original_url varchar
  feed_url varchar
  thumb_url varchar
}

Table Accounts as A {
  id int [pk, increment]
  username varchar [unique, not null]
  avatar_photo_id int [ref: > P.photo_id]
  bio text
  created_at timestamp [default: `now()`]
}

Table Posts as Po {
  id int [pk, increment]
  account_id int [ref: > A.id, not null]
  title varchar [not null]
  headerContent text
  fullContent text
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table PostPhotos as PP {
  post_id int [ref: > Po.id, not null]
  photo_id int [ref: > P.photo_id, not null]
  sort_order int [default: 0]
  indexes {
    (post_id, photo_id) [pk]
  }
}

Table Comments as C {
  id int [pk, increment]
  account_id int [ref: > A.id, not null]
  post_id int [ref: > Po.id, not null]
  content text [not null]
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table Likes as L {
  account_id int [ref: > A.id, not null]
  post_id int [ref: > Po.id, not null]
  created_at timestamp [default: `now()`]
  indexes {
    (account_id, post_id) [pk]
  }
}

Table Views as V {
  account_id int [ref: > A.id, not null]
  post_id int [ref: > Po.id, not null]
  created_at timestamp [default: `now()`]
  indexes {
    (account_id, post_id) [pk]
  }
}

Table Shares as S {
  account_id int [ref: > A.id, not null]
  post_id int [ref: > Po.id, not null]
  created_at timestamp [default: `now()`]
  indexes {
    (account_id, post_id) [pk]
  }
}

Table AccountComplaints as AC {
  id int [pk, increment]
  sender_account_id int [ref: > A.id, not null]
  account_id int [ref: > A.id, not null]
  cause text [not null]
  created_at timestamp [default: `now()`]
}

Table PostComplaints as PC {
  id int [pk, increment]
  sender_account_id int [ref: > A.id, not null]
  post_id int [ref: > Po.id, not null]
  cause text [not null]
  created_at timestamp [default: `now()`]
}

Table CommentComplaints as CC {
  id int [pk, increment]
  sender_account_id int [ref: > A.id, not null]
  comment_id int [ref: > C.id, not null]
  cause text [not null]
  created_at timestamp [default: `now()`]
}