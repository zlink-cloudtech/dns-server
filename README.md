# DNS Server

A DNS server based on Unbound, configured for custom hosts and upstream resolution.

## For Users: Running and Using the DNS Server

### Prerequisites

- Docker and Docker Compose installed on your system.

### Running the DNS Server

1. Clone or download this repository.

2. Navigate to the project directory:

   ```bash
   cd dns-server
   ```

3. Start the DNS server using Docker Compose:

   ```bash
   docker-compose up -d
   ```

   This will start the DNS server in the background, listening on port 53 (UDP and TCP).

### Configuring Your System to Use the DNS Server

To use this DNS server, configure your system's DNS settings to point to the container's IP address or use port forwarding.

- **On Linux/macOS**: Edit `/etc/resolv.conf` or use network settings to set the DNS server to `127.0.0.1` (if port forwarding is set up) or the container's IP.

- **On Windows**: Go to Network Settings > Change adapter options > Properties > Internet Protocol Version 4 (TCP/IPv4) > Properties > Use the following DNS server addresses, and enter the container's IP.

- **Using Docker Compose**: The `docker-compose.yaml` exposes port 53, so you can point to `127.0.0.1` if running locally.

### Testing the DNS Server

After starting the server, test if it's working by querying some domains:

1. Use `nslookup` or `dig` to query a domain:

   ```bash
   nslookup github.com 127.0.0.1
   ```

   Or if using the container directly:

   ```bash
   docker-compose exec dns-server nslookup github.com
   ```

2. Expected output: You should see the IP address of the domain resolved.

3. Test custom hosts: If configured, query domains that should resolve to custom IPs.

4. Check logs for any errors:

   ```bash
   docker-compose logs dns-server
   ```

### Stopping the Server

To stop the DNS server:

```bash
docker-compose down
```

## For Developers: Building the Images

The `Makefile` provides targets to build Docker images for different CPU architectures.

### Prerequisites

- Docker with BuildKit support (`DOCKER_BUILDKIT=1` is enabled by default on recent releases)

### Build individual architectures

```bash
make build-amd64
make build-arm64
```

Each target produces an image tagged with the platform suffix and version (for example `zlink-cloudtech/dns-server-amd64:latest`).

You can override the base image used per architecture:

```bash
make build-arm64 BASE_IMAGE_ARM64=alpinelinux/unbound:v1.21.0-aarch64
```

### Build all architectures

```bash
make build-all
```

This target builds both AMD64 and ARM64 images sequentially.

### Environment Variables

- `IMAGE_VER`: Version tag for the images (default: `latest`)
- `BASE_IMAGE_AMD64`: Base image for AMD64 builds (default: `alpinelinux/unbound:latest`)
- `BASE_IMAGE_ARM64`: Base image for ARM64 builds (default: `alpinelinux/unbound:latest-aarch64`)
- `COUNTRY`: Set to `CN` to use Chinese mirrors during build
- `PUSH_IMAGE`: Set to `YES` to push images after building

Example:

```bash
make build-all IMAGE_VER=v1.0.0 COUNTRY=CN PUSH_IMAGE=YES
```
