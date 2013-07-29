From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 29 Jul 2013 16:11:44 +0200
Subject: [GIT PULL FOR v3.12] sh-pfc fixes and enhancements
Message-ID: <4601856.fyKLDdx1qP@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git pinmux/next/fixes

for you to fetch changes up to e120cacfaac24d4de31b181371daaef6a5773ee3:

  sh-pfc: r8a7790: Add VIN pin groups and functions (2013-07-29 15:52:14 
+0200)

The patches don't conflict with the 'pin-no-gpio' series, the two series can 
be applied independently.

----------------------------------------------------------------
Kunihito Higashiyama (1):
      sh-pfc: r8a7790: Add MSIOF pin groups and functions

Laurent Pinchart (5):
      sh-pfc: Remove unneeded mach/<soc>.h includes
      sh-pfc: sh7372: Replace <mach/irqs.h> with <linux/sh_intc.h>
      sh-pfc: sh73a0: Remove EXT_IRQ16L and EXT_IRQ16H macros
      sh-pfc: r8a7790: Sort pin groups and functions alphabetically
      sh-pfc: r8a7790: Add SCIF2 pin groups and functions

Phil Edworthy (1):
      sh-pfc: r8a7779: Add I2C pin groups

Shinobu Uehara (2):
      sh-pfc: r8a7790: Add USB pin groups and functions
      sh-pfc: r8a7790: Add VIN pin groups and functions

Shinya Kuribayashi (9):
      sh-pfc: r8a7790: Rename I2C SDA/SCL pins
      sh-pfc: r8a7790: Remove trailing '_TANS' string from RTS/CTS pins
      sh-pfc: r8a7790: Remove deprecated Ethernet MII/RMII pins
      sh-pfc: r8a7790: Remove deprecated RDS pins
      sh-pfc: r8a7790: Remove deprecated SPV_EVEN pin
      sh-pfc: r8a7790: Swap SCIFA2_RXD_B and HRX0_C configurations
      sh-pfc: r8a7790: Add TCLK1 pin configuration support
      sh-pfc: r8a7790: Add SCIF2 pins configuration support
      sh-pfc: r8a7790: Fix miscellaneous pinmux configuration tables mistakes

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |    1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  105 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 1621 ++++++++++++++++++++-------------
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |    4 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |   68 +-
 6 files changed, 1132 insertions(+), 668 deletions(-)

-- 
Regards,

Laurent Pinchart
