const express = require('express');
const app = express();

// HTTPメソッドを無視してエンドポイント名でソート
// keep-sorted start ignore_prefixes=app.get,app.post,app.put,app.delete
app.post('/auth/login', loginHandler);
app.get('/comments', getCommentsHandler);
app.get('/posts', getPostsHandler);
app.put('/posts/:id', updatePostHandler);
app.post('/users', createUserHandler);
app.get('/users', getUsersHandler);
app.delete('/users/:id', deleteUserHandler);
// keep-sorted end

app.listen(3000);
