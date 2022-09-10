# latest rust will be used to build the binary
FROM rust:latest as builder

# the temporary directory where we build
WORKDIR /usr/src/microbin

# copy sources to /usr/src/microbin on the temporary container
COPY . .

# run release build
RUN cargo build --release

# create final container using bitnami/minideb
FROM bitnami/minideb

# data stored in /data
WORKDIR /data

# copy built executable
COPY --from=builder /usr/src/microbin/target/release/microbin /usr/local/bin/microbin

# run the binary
ENTRYPOINT ["/usr/local/bin/microbin"]
