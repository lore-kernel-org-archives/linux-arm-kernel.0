From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Dec 2015 13:06:36 -0800
Subject: [GIT PULL 3/4] omap wakeup-m3 driver for v4.5 merge window
In-Reply-To: <pull-1450731519-787330>
References: <pull-1450731519-787330>
Message-ID: <pull-1450731519-787330-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/wakeup-m3

for you to fetch changes up to cdd5de500b2c90d5181ebc963826019a0a4234ba:

  soc: ti: Add wkup_m3_ipc driver (2015-12-03 07:24:29 -0800)

----------------------------------------------------------------
TI wakeup M3 IPC device driver for v4.5 merge window. This driver will
eventually allow am33xx and am437x to support PM with their Cortex-M3
power management processor.

This driver has been waiting to get merged for quite a while but has
had dependencies to the remoteproc that are now out of the way.

----------------------------------------------------------------
Dave Gerlach (2):
      Documentation: dt: add bindings for TI Wakeup M3 IPC device
      soc: ti: Add wkup_m3_ipc driver

 .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt     |  57 +++
 drivers/soc/ti/Kconfig                             |  10 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/wkup_m3_ipc.c                       | 508 +++++++++++++++++++++
 include/linux/wkup_m3_ipc.h                        |  55 +++
 5 files changed, 631 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
 create mode 100644 drivers/soc/ti/wkup_m3_ipc.c
 create mode 100644 include/linux/wkup_m3_ipc.h
