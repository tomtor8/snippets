# log.lua

A lightweight, customizable logging library for Lua with colorized console output and file logging support.

---

## Features

- **6 Logging Levels:** `trace`, `debug`, `info`, `warn`, `error`, and `fatal`.
- **ANSI Color Support:** Color-coded terminal output for quick visual debugging.
- **File Logging:** Automatically append log entries to a designated log file.
- **Source Line Info:** Includes the originating file name and line number for every log call.
- **Number Formatting:** Auto-rounds floating-point numbers to two decimal places for cleaner output.

---

## Installation

Simply drop `log.lua` into your project directory and require it:

```lua
local log = require("log")
```

---

## Quick Start

```lua
local log = require("log")

-- Log messages at different severity levels
log.trace("Tracing variable state:", x)
log.debug("User session created", { id = 42 })
log.info("Server started on port", 8080)
log.warn("High memory usage detected:", 85.4)
log.error("Failed to connect to database!")
log.fatal("Unhandled exception, shutting down.")
```

---

## Configuration

You can configure the logging behavior directly by modifying properties on the `log` module:

```lua
local log = require("log")

-- Set minimum logging level (default: "debug")
-- Options: "trace", "debug", "info", "warn", "error", "fatal"
log.level = "info"

-- Enable or disable ANSI colors in terminal output (default: true)
log.usecolor = true

-- Specify log file path (set to `nil` to disable file logging)
log.outfile = "app.log"
```

---

## Output Format

### Terminal Output

Format: `[LEVEL  HH:MM:SS] path/to/file.lua:line: message`

Example:

```text
[INFO  14:32:01] main.lua:12: Server started on port 8080
```

### File Output

Format: `[LEVEL  Weekday Month Day HH:MM:SS Year] path/to/file.lua:line: message`

Example:

```text
[INFO  Tue Sep 22 14:32:01 2026] main.lua:12: Server started on port 8080
```

---

## 📄 License

MIT License © [rxi](https://github.com/rxi)
