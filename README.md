# Linux Monitoring Scripts

A set of Bash scripts for monitoring core system health on Linux servers:
disk usage, memory usage, and CPU load. Each script reads live system data,
compares it against a configurable threshold, and prints an OK or ALERT status.

Built as part of my cloud engineering learning path.

## Scripts

| Script | What it does |
|--------|--------------|
| `disk-monitor.sh` | Checks usage of every real disk (`/dev/*`), skips temporary filesystems, alerts if any disk is at or above the threshold. |
| `memory-monitor.sh` | Reads total and used RAM, calculates usage as a percentage, alerts if it crosses the threshold. |
| `cpu-monitor.sh` | Reads the 1-minute CPU load average, alerts if it is at or above the threshold. |

## Usage

Make a script executable, then run it:

```bash
chmod +x disk-monitor.sh
./disk-monitor.sh
```

Each script has a `THRESHOLD` variable at the top you can adjust to your needs.

## Example output
