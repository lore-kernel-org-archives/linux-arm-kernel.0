From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Feb 2011 22:30:22 +0100
Subject: [PATCH 0/5] my imx patches for 2.6.39
Message-ID: <20110218213022.GJ22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

apart from the patches below there is another patch not yet applied.
That's "mxs: irq_data conversion" that was already sent on this list.
Because I assumed that it belongs to Russells domain I sent it to the
patch system as
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6744/1
.  If you prefer, I can add it to this series; just tell me.

The following changes since commit b807afe41ceefef11a0d965cd9970142afc53d25:

  ARM: imx50: correct iomux-mx50.h wrong daisy chain settings (2011-02-18 11:01:34 +0100)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git imx-for-2.6.39

Lothar Wa?mann (2):
      ARM: mxs: free dma_mask in error path
      ARM: mxs: add a dma mask to fec devices

Sascha Hauer (1):
      ARM: mxs: Add pwm clocks and device registration

Uwe Kleine-K?nig (2):
      ARM: mxc: free dma_mask in error path
      ARM: mxc: add a dma mask to fec devices

 arch/arm/mach-mxs/Kconfig                       |    2 ++
 arch/arm/mach-mxs/clock-mx23.c                  |    6 +++++-
 arch/arm/mach-mxs/clock-mx28.c                  |    9 ++++++++-
 arch/arm/mach-mxs/devices-mx23.h                |    2 ++
 arch/arm/mach-mxs/devices-mx28.h                |    2 ++
 arch/arm/mach-mxs/devices.c                     |    2 ++
 arch/arm/mach-mxs/devices/Kconfig               |    3 +++
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-fec.c        |    5 +++--
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c    |   22 ++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++++
 arch/arm/plat-mxc/devices.c                     |    2 ++
 arch/arm/plat-mxc/devices/platform-fec.c        |    4 ++--
 13 files changed, 58 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-pwm.c

I will follow up with the patches as reply to this mail.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
