## 🎬 **Red Rating – Logic Flow Overview**

### 🧠 Core Features (Assumptions):

1. Browse/search for movies
2. View movie details
3. Submit a rating (1–5 stars)
4. View average rating & reviews
5. (Optional) User authentication

---

## 🔄 Logic Flow

### 1. **User opens the app (Frontend)**

* Frontend (Angular) loads homepage
* Shows featured movies or search bar

---

### 2. **User searches or browses for a movie**

* Angular makes a call to backend via API Gateway

  * e.g., `GET /movies?query=inception`
* Python backend (on Lambda):

  * Queries a movie database (like OMDb API or your DB)
  * Returns movie results to frontend
* Angular displays movie cards with titles and thumbnails

---

### 3. **User selects a movie**

* Angular routes to `MovieDetailComponent`
* Calls backend:

  * `GET /movies/<movie_id>`
  * Returns detailed info and ratings
* Angular displays:

  * Title, poster, synopsis
  * Average rating
  * Review list

---

### 4. **User submits a rating**

* Angular UI has a star rating and comment box
* User clicks submit → `POST /movies/<movie_id>/ratings`

  * Payload: `{ user_id, rating, comment }`
* Python backend:

  * Authenticates the user (if login is enabled)
  * Saves rating in database
  * Recalculates average rating

---

### 5. **UI updates with new rating**

* Backend returns updated rating stats
* Angular updates movie detail page with new average

---

## 🔐 Optional: Authentication Flow

* Login screen → `POST /auth/login`
* Token-based auth (JWT)
* Token stored in localStorage/sessionStorage
* Sent with requests needing user identity (like ratings)

---

## 🧱 Architecture Summary

| Component        | Technology            | Role                               |
| ---------------- | --------------------- | ---------------------------------- |
| Frontend         | Angular               | UI, routing, calling APIs          |
| Frontend Hosting | EC2 (Node.js/Express) | Serves Angular app                 |
| Backend          | Python on AWS Lambda  | Handles data logic, APIs, auth     |
| API Gateway      | AWS API Gateway       | Entry point for frontend API calls |
| Database         | DynamoDB / RDS        | Stores movies, ratings, users      |
| Auth             | Cognito or custom JWT | Handles login and token auth       |

