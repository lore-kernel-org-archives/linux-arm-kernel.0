From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 27 Oct 2013 16:47:20 +0100
Subject: [GIT PULL FOR v3.13] SH Mobile PFC patches
Message-ID: <1863828.HbOPaS1OIe@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are two patches that I would like to get merged in v3.13 if possible. 
They first one adds CAN pin groups for the r8a7778 SoC, while the second one 
adds support for the r8a7791 SoC to the sh-pfc driver. Despite the large size 
of the diffstat there's nothing special to mention here.

The following changes since commit c6ce2b6bffe5740d572fdc5b5e690d5261abee51:

  gpio: add TB10x GPIO driver (2013-10-25 23:42:34 +0200)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pfc

for you to fetch changes up to 5088451962389924b9f05e22e6956f5c1a515d1a:

  pinctrl: sh-pfc: r8a7791 PFC support (2013-10-27 16:40:52 +0100)

----------------------------------------------------------------
Hisashi Nakamura (1):
      pinctrl: sh-pfc: r8a7791 PFC support

Sergei Shtylyov (1):
      sh-pfc: r8a7778: Add CAN pin groups

 drivers/pinctrl/sh-pfc/Kconfig       |    5 +
 drivers/pinctrl/sh-pfc/Makefile      |    1 +
 drivers/pinctrl/sh-pfc/core.c        |    9 +
 drivers/pinctrl/sh-pfc/core.h        |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   55 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 4214 +++++++++++++++++++++++++++++++++
 6 files changed, 4285 insertions(+)
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7791.c

-- 
Regards,

Laurent Pinchart
