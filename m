From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 25 Jul 2017 21:15:49 -0500
Subject: [PATCH 0/3] ARM: dts: am335x-evm: am437xx: dra7xx: Enable NAND DMA
 prefetch by default
Message-ID: <20170726021552.19880-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable NAND DMA prefetch by default for AM335x, AM437x and DRA7x evms that
include NAND.

The below commit went into additional details regarding performance numbers
seen between the two modes.

commit aa7abd312c11 ("mtd: nand: omap2: Support parsing dma channel information from DT")

Franklin S Cooper Jr (3):
  ARM: dts: am335x-evm: Enable NAND dma prefetch by default
  ARM: dts: am437xx: Enable NAND dma prefetch by default
  ARM: dts: dra7xx: Enable NAND dma prefetch by default

 arch/arm/boot/dts/am335x-evm.dts        | 1 +
 arch/arm/boot/dts/am437x-gp-evm.dts     | 1 +
 arch/arm/boot/dts/am43x-epos-evm.dts    | 1 +
 arch/arm/boot/dts/dra7-evm.dts          | 1 +
 arch/arm/boot/dts/dra72-evm-common.dtsi | 1 +
 5 files changed, 5 insertions(+)

-- 
2.10.0
