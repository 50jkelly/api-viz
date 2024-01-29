const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.set("Access-Control-Allow-Origin", "*")

  const data ={
    message: {
        "users": [
          {
            "id": 1,
            "name": "John Doe",
            "email": "johndoe@example.com",
            "roles": ["user", "admin"],
            "isActive": true
          },
          {
            "id": 2,
            "name": "Jane Smith",
            "email": "janesmith@example.com",
            "roles": ["user"],
            "isActive": false
          },
          {
            "id": 3,
            "name": "Emily Johnson",
            "email": "emilyjohnson@example.com",
            "roles": ["user", "editor"],
            "isActive": true
          }
        ]
      }
  }

  setTimeout(() => res.send(data), 3000)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})