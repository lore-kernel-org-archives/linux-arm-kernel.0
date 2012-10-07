From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun,  7 Oct 2012 14:02:10 +1300
Subject: [PATCH 0/4] arm-soc: vt8500: Cleanup patches for 3.7
Message-ID: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor cleanup patches for 3.7.

Tony Prisk (4):
  vt8500: Remove unused headers from include/mach/
  vt8500: Remove arm/boot/compressed/head-vt8500.S
  vt8500: Fix header in mach-vt8500/timer.c
  vt8500: Fix build warning when no framebuffer selected

 arch/arm/boot/compressed/Makefile            |    4 ---
 arch/arm/boot/compressed/head-vt8500.S       |   46 --------------------------
 arch/arm/mach-vt8500/include/mach/hardware.h |   12 -------
 arch/arm/mach-vt8500/include/mach/i8042.h    |   18 ----------
 arch/arm/mach-vt8500/include/mach/restart.h  |   17 ----------
 arch/arm/mach-vt8500/timer.c                 |    2 +-
 arch/arm/mach-vt8500/vt8500.c                |    7 ++--
 7 files changed, 5 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/head-vt8500.S
 delete mode 100644 arch/arm/mach-vt8500/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/i8042.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/restart.h

-- 
1.7.9.5
