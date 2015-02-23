From: rogerq@ti.com (Roger Quadros)
Date: Mon, 23 Feb 2015 17:18:35 +0200
Subject: [PATCH 0/2] ARM: omap2plus_defconfig: Fix SATA and NAND for v4.0-rc
Message-ID: <1424704717-29728-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These changes fix SATA boot and NAND for OMAP based boards.

I must also point out that basic SATA operation is also
broken when TI_PIPE3 driver is built as a module.
I will be investigating that on lower priority.

--
cheers,
-roger

Roger Quadros (2):
  ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
  ARM: omap2plus_defconfig: Fix SATA boot

 arch/arm/configs/omap2plus_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.1.0
