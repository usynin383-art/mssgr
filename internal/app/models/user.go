package models

import (
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID       int
	email    string
	passHash string
}

type TokenPair struct {
	AccessToken  string
	RefrashToken string
}

type RefrashSession struct {
	UserID    uuid.UUID
	ExpiresAt time.Time
}
