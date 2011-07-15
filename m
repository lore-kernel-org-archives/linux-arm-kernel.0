From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Jul 2011 11:23:07 +0200
Subject: [GIT PULL] more i.MX fixes
Message-ID: <20110715092307.GN6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following fixes for i.MX. These are orthogonal to
the branches you already pulled and this are directly based on Linus
tree.

Sascha

The following changes since commit 5dcd07b9f39ca3e9be5bcc387d193fc0674e1c81:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes (2011-07-14 10:20:42 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git fixes-for-arnd

Dong Aisheng (1):
      ARM: mxs-dma: include <linux/dmaengine.h>

Fabio Estevam (1):
      ARM: mx25: Fix typo on CAN1_RX pad setting

Lothar Wa?mann (1):
      iomux-mx53: add missing 'IOMUX_CONFIG_SION' for some I2C pad definitions

Troy Kisky (3):
      ARM: i.MX53: UARTn_TXD pin should not change RXD input select
      ARM: i.MX53: UARTn_CTS pin should not change RTS input select
      ARM: i.MX53: consistently use MX53_UART_PAD_CTRL for uart txd/rxd/rts/cts

 arch/arm/mach-mxs/include/mach/dma.h        |    2 +
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |  114 +++++++++++++-------------
 3 files changed, 60 insertions(+), 58 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
