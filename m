From: addy.ke@rock-chips.com (addy ke)
Date: Tue, 24 Jun 2014 11:58:42 +0800
Subject: [PATCH 0/2] add rockchip spi drive
Message-ID: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1 add rockchip spi documentation
Patch 2 add driver for Rockchip RK3XXX SoCs integrated SPI.

Tested on rk3288 sdk board with polling mode and DMA mode.

addy ke (2):
  documentation: add rockchip spi documentation
  spi: add driver for Rockchip RK3xxx SoCs integrated SPI

 .../devicetree/bindings/spi/spi-rockchip.txt       |  51 ++
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-rockchip.c                         | 894 +++++++++++++++++++++
 4 files changed, 957 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt
 create mode 100644 drivers/spi/spi-rockchip.c

-- 
1.8.3.2
