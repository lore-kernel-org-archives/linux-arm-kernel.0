From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Fri, 20 Jan 2012 18:58:21 +0100
Subject: [PATCH 0/3] mx31moboard update
Message-ID: <1327082304-11398-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The first patch update the maintainer of the mx31moboard boards.
Valentin does not work at epfl anymore.

The last one is a real fix for the sdma engine. 
Without it DMA on SD card is broken on i.MX31. 

Thanks,
Philippe


Philippe R??tornaz (3):
  mx31moboard: update maintainer
  mx31moboard: Add watchdog support
  i.MX SDMA: Fix burstsize settings

 arch/arm/mach-imx/Kconfig            |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c |    4 +++-
 drivers/dma/imx-sdma.c               |    6 ++++--
 3 files changed, 8 insertions(+), 3 deletions(-)
