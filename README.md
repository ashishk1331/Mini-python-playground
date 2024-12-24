## API

exposed @ localhost:8000

### Run the API

run the command,

```bash
air
```

### Routes

All routes are prefixed with `/api/v1` for the version one API routes.

2. **POST** `/run`
   It takes the python code as `content` in the body of the request, and throws out metrics and run of the code.

   sample url,

   ```json
   {
      "content": "def add(a, b):\n    return a + b\nprint(add(2, 5))"
   }
   ```

   eg:

   ```json
   {
      "error": "",
      "ok": true,
      "output": "7\r\n",
      "time_taken": 8993200,
      "time_units": "ns"
   }
   ```
