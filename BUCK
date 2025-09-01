load("@prelude//genrule.bzl", "genrule")

# Root build file for monobean Tauri application using Buck2

# Frontend build target - builds the React/TypeScript app
genrule(
    name = "frontend",
    cmd = "cd /home/runner/work/monobean/monobean && npm run build && tar -czf $OUT -C dist .",
    out = "frontend-dist.tar.gz",
    visibility = ["PUBLIC"],
)

# Backend Rust build target - builds the Tauri Rust backend
genrule(
    name = "backend", 
    cmd = "cd /home/runner/work/monobean/monobean/src-tauri && cargo build --release && tar -czf $OUT -C target/release .",
    out = "backend-release.tar.gz",
    visibility = ["PUBLIC"],
)

# Full Tauri application build - complete app with bundling
genrule(
    name = "monobean",
    cmd = "cd /home/runner/work/monobean/monobean && npm run tauri build && find src-tauri/target/release/bundle -name '*.AppImage' -o -name '*.deb' -o -name '*.rpm' | head -1 | xargs -I {} cp {} $OUT || cp $(find src-tauri/target/release -name 'gitmono*' -executable -type f | head -1) $OUT",
    out = "monobean-app",
    visibility = ["PUBLIC"],
)

# Quick frontend build check  
genrule(
    name = "check-frontend",
    cmd = "cd /home/runner/work/monobean/monobean && npx tsc --noEmit && echo 'Frontend TypeScript check passed' > $OUT",
    out = "frontend-check.log",
    visibility = ["PUBLIC"],
)

# Quick backend build check
genrule(
    name = "check-backend",
    cmd = "cd /home/runner/work/monobean/monobean/src-tauri && cargo check && echo 'Backend Rust check passed' > $OUT",
    out = "backend-check.log", 
    visibility = ["PUBLIC"],
)