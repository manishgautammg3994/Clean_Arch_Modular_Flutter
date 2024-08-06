# antinna
```bash
find . -type d -empty -exec touch {}/.gitkeep \;

```

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Structure

```
├── lib
│   ├── core
│   │   ├── data
│   │   │   ├── sources
│   │   │   │   ├── remote
│   │   │   │   │   ├── models
│   │   │   │   │   └── services
│   │   │   │   └── local
│   │   │   │       └── models
│   │   │   └── repositories
│   │   ├── domain
│   │   │   └── entities
│   │   └── presentation
│   │       └── utils
│   ├── features
│   │   ├── auth
│   │   │   ├── data
│   │   │   │   ├── sources
│   │   │   │   │   ├── remote
│   │   │   │   │   │   ├── models
│   │   │   │   │   │   └── services
│   │   │   │   │   └── local
│   │   │   │   │       └── models
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   └── entities
│   │   │   └── presentation
│   │   │       └── screens
│   │   ├── home
│   │   │   ├── data
│   │   │   │   ├── sources
│   │   │   │   │   ├── remote
│   │   │   │   │   │   ├── models
│   │   │   │   │   │   └── services
│   │   │   │   │   └── local
│   │   │   │   │       └── models
│   │   │   │   └── repositories
│   │   │   ├── domain
│   │   │   │   └── entities
│   │   │   └── presentation
│   │   │       └── screens
│   │   └── profile
│   │       ├── data
│   │       │   ├── sources
│   │       │   │   ├── remote
│   │       │   │   │   ├── models
│   │       │   │   │   └── services
│   │       │   │   └── local
│   │       │   │       └── models
│   │       │   └── repositories
│   │       ├── domain
│   │       │   └── entities
│   │       └── presentation
│   │           └── screens
│   └── main.dart
└── test
    └── features
        └── auth
            └── data
                └── sources
                    └── remote
                        └── models
                            └── login_request_test.dart

