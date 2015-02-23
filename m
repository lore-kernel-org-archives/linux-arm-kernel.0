From: rogerq@ti.com (Roger Quadros)
Date: Mon, 23 Feb 2015 17:18:36 +0200
Subject: [PATCH 1/2] ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
In-Reply-To: <1424704717-29728-1-git-send-email-rogerq@ti.com>
References: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Message-ID: <1424704717-29728-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this NAND doesn't work on most EVMs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b738652..b674245 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -114,6 +114,7 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_OMAP_BCH=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_OMAP2=y
-- 
2.1.0
