# keep-sorted Use Cases

## 1. Markdown Tables
<!-- keep-sorted start skip_lines=2 -->
| Name | Age | City |
|------|-----|------|
| Alice | 28 | Osaka |
| Bob | 42 | Kyoto |
| Charlie | 35 | Tokyo |
<!-- keep-sorted end -->

## 2. Enum Definitions
```python
class Status:
    # keep-sorted start
    CANCELLED = "cancelled"
    COMPLETED = "completed"
    FAILED = "failed"
    PENDING = "pending"
    RUNNING = "running"
    # keep-sorted end
```

## 3. Feature Flags
```javascript
const FEATURES = {
  // keep-sorted start
  ENABLE_ANALYTICS: true,
  ENABLE_BETA_UI: false,
  ENABLE_DARK_MODE: true,
  ENABLE_EXPERIMENTAL: false,
  ENABLE_NOTIFICATIONS: true,
  // keep-sorted end
};
```

## 4. API Endpoints
```go
// keep-sorted start prefix_order=/api/v1,/api/v2,/internal
/api/v1/comments
/api/v1/posts
/api/v1/users
/api/v2/analytics
/api/v2/users
/internal/health
/internal/metrics
// keep-sorted end
```

## 5. Dependencies (package.json style)
```json
{
  "dependencies": {
    // keep-sorted start
    "axios": "^1.0.0",
    "express": "^4.18.0",
    "lodash": "^4.17.21",
    "react": "^18.0.0",
    "typescript": "^5.0.0"
    // keep-sorted end
  }
}
```
