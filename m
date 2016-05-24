From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 25 May 2016 00:56:37 +0200
Subject: [PATCH 0/5] sunxi spi fixes
Message-ID: <cover.1464130597.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series addresses some issues with sunxi SPI drivers.

The last patch adding DMA support is not completed. It addresses some issues
with the previous version of the patch and it works in practice but some issues
still remain.

Thanks

Michal

Emilio L?pez (1):
  RFC spi: sun4i: add DMA support

Michal Suchanek (4):
  spi: sunxi: fix transfer timeout
  spi: sun4i: fix FIFO limit
  spi: sunxi: expose maximum transfer size limit
  spi: sunxi: set maximum and minimum speed of SPI master

 drivers/spi/spi-sun4i.c | 186 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/spi/spi-sun6i.c |  20 +++++-
 2 files changed, 194 insertions(+), 12 deletions(-)

-- 
2.8.1
