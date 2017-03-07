From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 7 Mar 2017 15:57:49 -0600
Subject: [PATCH 0/2] ARM: dts: am335x-icev2: Add support for W25Q64 NOR flash
Message-ID: <20170307215751.29266-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the on board SPI NOR flash on TI's AM335x
Industrial Communication Engine rev 2.x board.

Franklin S Cooper Jr (1):
  ARM: dts: am335x-icev2: Add SPI based NOR

Sekhar Nori (1):
  doc: dt: mtd: add w25q64 to list of supported SPI flashes

 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  1 +
 arch/arm/boot/dts/am335x-icev2.dts                 | 33 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.10.0
