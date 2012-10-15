From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 15 Oct 2012 14:19:01 +1300
Subject: [PULL REQUEST] ARM: vt8500: Cleanup for 3.8
Message-ID: <1350263941.3458.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit
ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git/ tags/cleanup-for-3.8

for you to fetch changes up to 83cc76909622a4ee21f750148e779104d0606e9f:

  vt8500: Fix header in mach-vt8500/timer.c (2012-10-15 14:04:41 +1300)

----------------------------------------------------------------
Cleanup for 3.8

Removes a few unused headers from include/mach
Removes unused arm/boot/compressed/head-vt8500.S
Fixes header text in mach-vt8500/timer.c

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

----------------------------------------------------------------
Tony Prisk (3):
      vt8500: Remove unused headers from include/mach/
      vt8500: Remove arm/boot/compressed/head-vt8500.S
      vt8500: Fix header in mach-vt8500/timer.c

 arch/arm/boot/compressed/Makefile            |    4 ---
 arch/arm/boot/compressed/head-vt8500.S       |   46
--------------------------
 arch/arm/mach-vt8500/include/mach/hardware.h |   12 -------
 arch/arm/mach-vt8500/include/mach/i8042.h    |   18 ----------
 arch/arm/mach-vt8500/include/mach/restart.h  |   17 ----------
 arch/arm/mach-vt8500/timer.c                 |    2 +-
 arch/arm/mach-vt8500/vt8500.c                |    2 --
 7 files changed, 1 insertion(+), 100 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/head-vt8500.S
 delete mode 100644 arch/arm/mach-vt8500/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/i8042.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/restart.h
