From: samreen@ti.com (Samreen)
Date: Tue, 16 Nov 2010 09:23:38 +0530
Subject: [Repost][PATCH v3 0/2] OMAP3: Display Support
Message-ID: <1289879620-4696-1-git-send-email-samreen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the Display Support for OMAP3 platforms
and the corresponding changes in the board files.

Version3:
   - Rebase to the latest LO
Version2:
   - Optimised to configure INTBR from gpio to PWM1 mode setting and 
   enabling of the PWM1 mode only when its not in PWM1 mode.

Kishore Y (2):
  OMAP3: ZOOM2/3/3630SDP: Add display board file for OMAP3
  OMAP3: Enable display on ZOOM2/3/3630SDP

 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  168 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   49 +++++++-
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
 7 files changed, 224 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-display.c
