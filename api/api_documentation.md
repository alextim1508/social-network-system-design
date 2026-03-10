# Документация API

## Содержание

- [Фото](#photo)
- [Посты](#posts)
- [Комментарии](#comments)
- [Лайки и дизлайки](#likes-and-dislikes)
- [Аккаунты](#accounts)
- [Уведомления](#notifications)
- [Теги](#tags)
- [Места](#locations)
- [Поиск](#search)

---
<a id="photo"></a>
## Фото

### Загрузка фото

- **POST** `/photo`
    - **Content-Type:** `application/json`
    - **Тело запроса:**
      ```json
      {
        "bytes": "/9j/4AAQSkZJRgABAQAAAQ..."
      }
      ```
    - **Ответ:**
        - **Status:** `201 Created`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "photoId": 1
          }
          ```

### Получение фото

- **GET** `/photo/{photoId}/original`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `image/jpeg`
        - **Body:** `RAW BYTES (Full Resolution)`
- **GET** `/photo/{photoId}/feed`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `image/jpeg`
        - **Body:** `RAW BYTES (Optimized for Feed, e.g. 600x600)`
- **GET** `/photo/{photoId}/thumb`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `image/jpeg`
        - **Body:** `RAW BYTES (Thumbnail, e.g. 150x150)`

### Получение фото поста

- **GET** `/post/{id}/photo`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "photoIds": [1, 2, 3]
          }
          ```

---
<a id="posts"></a>
## Посты

### Создание поста

- **POST** `/post`
    - **Content-Type:** `application/json`
    - **Тело запроса:**
      ```json
      {
        "title": "Trip to Paris",
        "content": "Amazing city!",
        "photoIds": [1, 2, 3]
      }
      ```
    - **Ответ:**
        - **Status:** `201 Created`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "id": 1,
            "title": "Trip to Paris",
            "content": "Amazing city!",
            "photoIds": [1, 2, 3],
            "createdAt": "2026-03-10T10:00:00Z"
          }
          ```

### Редактирование поста

- **PUT** `/post/{postId}`
    - **Content-Type:** `application/json`
    - **Тело запроса:**
      ```json
      {
        "title": "Trip to Paris",
        "content": "Amazing city!",
        "photoIds": [1, 2, 3]
      }
      ```
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "id": 1,
            "title": "Trip to Paris",
            "content": "Amazing city! (Updated)",
            "photoIds": [1, 2, 3],
            "updatedAt": "2026-03-10T10:15:00Z"
          }
          ```

### Удаление поста

- **DELETE** `/post/{postId}`
    - **Ответ:**
        - **Status:** `204 No Content`

### Просмотр поста

- **GET** `/post/{id}`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "postId": 1,
            "author": "john_doe",
            "authorId": 2,
            "title": "Trip to Paris",
            "fullContent": "Amazing city!",
            "likeCount": 10,
            "commentCount": 2,
            "photoIds": [1, 2]
          }
          ```

### Получение статистики по посту

- **GET** `/post/{id}/stats`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "views": 1250,
            "likes": 120,
            "comments": 25,
            "shares": 5
          }
          ```

---
<a id="comments"></a>
## Комментарии

### Создание комментария

- **POST** `/post/{id}/comment`
    - **Content-Type:** `application/json`
    - **Тело запроса:**
      ```json
      {
        "content": "Great photo!"
      }
      ```
    - **Ответ:**
        - **Status:** `201 Created`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "id": 1,
            "author": "user1",
            "content": "Great photo!",
            "createdAt": "2026-03-10T10:00:00Z"
          }
          ```

### Редактирование комментария

- **PUT** `/post/{id}/comment/{commentId}`
    - **Content-Type:** `application/json`
    - **Тело запроса:**
      ```json
      {
        "content": "Updated comment!"
      }
      ```
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "id": 1,
            "author": "user1",
            "content": "Updated comment!",
            "createdAt": "2026-03-10T10:00:00Z"
          }
          ```

### Получение комментариев поста

- **GET** `/post/{id}/comment`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "comments": [
              {
                "id": 1,
                "author": "user1",
                "content": "Great shot!",
                "createdAt": "2026-03-10T10:00:00Z"
              }
            ]
          }
          ```

### Получение конкретного комментария

- **GET** `/post/{id}/comment/{id}`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "id": 1,
            "author": "user1",
            "content": "Great shot!",
            "createdAt": "2026-03-10T10:00:00Z"
          }
          ```

### Удаление комментария

- **DELETE** `/post/{id}/comment/{id}`
    - **Ответ:**
        - **Status:** `204 No Content`

### Создание жалобы на комментарий

- **POST** `/post/{id}/comment/{commentId}/complaint`
    - **Content-Type:** `application/json`
    - **Тело запроса:**
      ```json
      {
        "reason": "spam"
      }
      ```
    - **Ответ:**
        - **Status:** `204 No Content`

---
<a id="likes-and-dislikes"></a>
## Лайки и дизлайки

### Лайкнуть пост

- **POST** `/post/{id}/like`
    - **Ответ:**
        - **Status:** `204 No Content`

### Дизлайкнуть пост

- **POST** `/post/{id}/dislike`
    - **Ответ:**
        - **Status:** `204 No Content`

---
<a id="accounts"></a>
## Аккаунты

### Просмотр аккаунта

- **GET** `/account/{id}`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "id": 1,
            "name": "john_doe",
            "info": "Travel enthusiast",
            "avatarId": 1,
            "postCount": 120,
            "followerCount": 100,
            "followingCount": 25
          }
          ```

### Получение лайкнутых постов пользователем

- **GET** `/account/{id}/liked-posts`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "posts": [
              {
                "postId": 50,
                "author": "another_user",
                "title": "Sunset in Bali",
                "likeDate": "2026-03-09T15:00:00Z"
              }
            ]
          }
          ```

### Подписка

- **POST** `/account/{id}/subscribe`
    - **Ответ:**
        - **Status:** `204 No Content`

### Отписка

- **DELETE** `/account/{id}/subscribe`
    - **Ответ:**
        - **Status:** `204 No Content`

### Подписчики пользователя

- **GET** `/account/{id}/followers`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "accounts": [
              {
                "id": 101,
                "name": "traveler_1",
                "avatarId": 5
              }
            ]
          }
          ```

### Подписки пользователя

- **GET** `/account/{id}/following`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "accounts": [
              {
                "id": 102,
                "name": "traveler_2",
                "avatarId": 6
              }
            ]
          }
          ```

---
<a id="notifications"></a>
## Уведомления

### Получение уведомлений

- **GET** `/notifications`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "notifications": [
              {
                "id": 1,
                "type": "like",
                "fromUser": "user_123",
                "postId": 456,
                "read": false,
                "timestamp": "2026-03-10T09:00:00Z"
              },
              {
                "id": 2,
                "type": "comment",
                "fromUser": "user_456",
                "postId": 456,
                "commentId": 789,
                "read": true,
                "timestamp": "2026-03-10T08:30:00Z"
              }
            ]
          }
          ```

### Отметить уведомление как прочитанное

- **POST** `/notifications/{id}/mark-as-read`
    - **Ответ:**
        - **Status:** `204 No Content`

---
<a id="tags"></a>
## Теги

### Получение популярных тегов

- **GET** `/tags/popular`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "tags": [
              {
                "name": "sunset",
                "postCount": 5000
              }
            ]
          }
          ```

### Получение постов по тегу

- **GET** `/tag/{name}/posts`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "posts": [
              {
                "postId": 1,
                "author": "john_doe",
                "authorId": 2,
                "title": "Trip to Paris",
                "headerContent": "Amazing city!",
                "likeCount": 10,
                "commentCount": 2,
                "photoIds": [1, 2]
              }
            ]
          }
          ```

---
<a id="locations"></a>
## Места

### Получение популярных мест

- **GET** `/locations/popular`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "locations": [
              {
                "name": "Eiffel Tower",
                "lat": 48.8584,
                "lng": 2.2945,
                "postCount": 1500
              }
            ]
          }
          ```

---

## Поиск

### Лента постов на основе подписок

- **GET** `/post`

### Лента постов пользователя

- **GET** `/account/{id}/post`

### Поиск постов по фрагменту

- **GET** `/post/search?query=Paris`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          [
            {
              "postId": 1,
              "author": "john_doe",
              "authorId": 2,
              "title": "Trip to Paris",
              "headerContent": "Amazing city!",
              "likeCount": 10,
              "commentCount": 2,
              "photoIds": [1, 2]
            }
          ]
          ```

### Поиск постов по координатам

- **GET** `/post/search?lat=48.8566&lon=2.3522`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          [
            {
              "postId": 1,
              "author": "john_doe",
              "authorId": 2,
              "title": "Trip to Paris",
              "headerContent": "Amazing city!",
              "likeCount": 10,
              "commentCount": 2,
              "photoIds": [1, 2]
            }
          ]
          ```

### Поиск аккаунта

- **GET** `/account/search?query=john`
    - **Ответ:**
        - **Status:** `200 OK`
        - **Content-Type:** `application/json`
        - **Тело:**
          ```json
          {
            "accounts": [
              {
                "id": 1,
                "name": "john_doe",
                "postCount": 120
              }
            ]
          }
          ```

### Создание жалобы на пост

- **POST** `/post/{id}/complaint`
    - **Content-Type:** `application/json`
    - **Тело запроса:**
      ```json
      {
        "cause": "spam"
      }
      ```
    - **Ответ:**
        - **Status:** `204 No Content`


[OpenAPI 3.0](./rest_api.yml)