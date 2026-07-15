# build-your-own-os
 
```
├── Makefile
├── arch/i386/                  # x86-specific bootstrap & low-level code
│   ├── gdt.cpp
│   ├── gdt.h
│   ├── interrupts.cpp
│   ├── interrupts.h
│   ├── interruptstubs.s        # Assembly stubs next to their C++ handlers
│   ├── io.h                    # Replaces port.h (in/out assembly instructions)
│   └── loader.s                # Bootloader entry point
│
├── core/                       # Core kernel subsystems
│   ├── kernel.cpp              # Kernel entry (kmain)
│   ├── mem.cpp                 # Replaces memorymanagement
│   ├── mem.h
│   ├── sched.cpp               # Replaces multitasking (Scheduler)
│   └── sched.h
│
├── drivers/                    # Hardware drivers
│   ├── am79c973.cpp            # Dropped the redundant 'amd_' prefix
│   ├── am79c973.h
│   ├── ata.cpp
│   ├── ata.h
│   ├── driver.cpp              # Base Driver class
│   ├── driver.h
│   ├── keyboard.cpp
│   ├── keyboard.h
│   ├── mouse.cpp
│   ├── mouse.h
│   ├── vga.cpp
│   └── vga.h
│
├── gui/                        # Graphics User Interface
│   ├── desktop.cpp
│   ├── desktop.h
│   ├── gfx.h                   # Replaces graphicscontext.h
│   ├── widget.cpp
│   ├── widget.h
│   ├── window.cpp
│   └── window.h
│
├── net/                        # Network Stack
│   ├── arp.cpp
│   ├── arp.h
│   ├── ethernet.cpp            # Replaces etherframe
│   ├── ethernet.h
│   ├── icmp.cpp
│   ├── icmp.h
│   ├── ipv4.cpp
│   ├── ipv4.h
│   ├── tcp.cpp
│   ├── tcp.h
│   ├── udp.cpp
│   └── udp.h
│
├── sys/                        # User-space facing interfaces
│   ├── syscall.cpp
│   └── syscall.h
│
└── include/                    # Global/Common definitions
    └── types.h                 # Fixed-width primitives (uint32_t, etc.)
```