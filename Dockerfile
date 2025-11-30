# ---- Build stage ----
FROM haskell:9.4.8 AS builder

WORKDIR /app
COPY . .

# Install dependencies and build only the executable
RUN cabal update && \
    cabal build exe:fileto --enable-optimization=2 && \
    cabal install exe:fileto --installdir=/app/install --overwrite-policy=always

# ---- Runtime stage ----
FROM debian:stable-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the installed binary (clean, predictable path)
COPY --from=builder /app/install/fileto /usr/local/bin/fileto

ENTRYPOINT ["fileto"]
