From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 28 Jul 2015 11:29:57 +0200
Subject: [PATCH 0/2] s3c64xx debug prints
Message-ID: <cover.1438075797.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

while debugging spi failures I found that debug prints provided by the driver
are insufficient.

The hardware specific driver is the only place in kernel where things like SPI
bus speed, used clock, transfer mode, etc. are known.

Thanks

Michal

Michal Suchanek (2):
  spi: s3c64xx: print fifo size on probe.
  spi: s3c64xx: add more debug prints.

 drivers/spi/spi-s3c64xx.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.1.4
