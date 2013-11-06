From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 10:05:41 +0000
Subject: [PATCH 0/7] ARM: ux500: More DT only clean-ups for the platform
Message-ID: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I was bored on the plane home, so knocked this together. This is
probably the penultimate set of clean-ups. The final one will be
the removal of MSP devices once my Audio patch-set lands.

 arch/arm/mach-ux500/Makefile             |   7 +++---
 arch/arm/mach-ux500/board-mop500-audio.c |   2 --
 arch/arm/mach-ux500/board-mop500-sdi.c   | 168 ----------------------------------------------------------------------------------------------------------------------------------
 arch/arm/mach-ux500/board-mop500.c       |  78 ------------------------------------------------------------
 arch/arm/mach-ux500/board-mop500.h       |   5 ----
 arch/arm/mach-ux500/cpu-db8500.c         |  18 +++++++++++---
 arch/arm/mach-ux500/cpu.c                |  23 +++++-------------
 arch/arm/mach-ux500/devices-db8500.c     |  28 ----------------------
 arch/arm/mach-ux500/devices-db8500.h     |  19 ---------------
 arch/arm/mach-ux500/devices.c            |  26 --------------------
 arch/arm/mach-ux500/devices.h            |  15 ------------
 arch/arm/mach-ux500/setup.h              |   6 -----
 arch/arm/mach-ux500/timer.c              |  28 +++++++---------------
 13 files changed, 32 insertions(+), 391 deletions(-)
