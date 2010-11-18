From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 18 Nov 2010 19:59:45 +0200
Subject: [PATCH 0/6] OMAP cleanups 
Message-ID: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some small OMAP cleanups to eliminate noise from compilation/sparse
checks:

Aaro Koskinen (6):
  arm: omap1: add missing includes
  arm: omap1: make some functions static
  arm: omap1: mbox: make variables static
  arm: omap1: mbox: delete unused variable
  arm: omap1: board-ams-delta: fix cast
  arm: omap2: timer-gp: delete unused variable

 arch/arm/mach-omap1/board-ams-delta.c |    3 ++-
 arch/arm/mach-omap1/devices.c         |    1 +
 arch/arm/mach-omap1/flash.c           |    1 +
 arch/arm/mach-omap1/mailbox.c         |    5 ++---
 arch/arm/mach-omap1/mcbsp.c           |    2 +-
 arch/arm/mach-omap1/mux.c             |    2 +-
 arch/arm/mach-omap1/serial.c          |    2 ++
 arch/arm/mach-omap1/time.c            |    1 +
 arch/arm/mach-omap2/timer-gp.c        |    3 +--
 arch/arm/plat-omap/dma.c              |    2 +-
 arch/arm/plat-omap/sram.c             |    2 +-
 11 files changed, 14 insertions(+), 10 deletions(-)
