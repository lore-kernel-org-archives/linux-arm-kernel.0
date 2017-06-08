From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Jun 2017 20:07:32 +0530
Subject: [PATCH 1/2] ARM: davinci_all_defconfig: enable mtdtests
In-Reply-To: <20170608143733.30004-1-nsekhar@ti.com>
References: <20170608143733.30004-1-nsekhar@ti.com>
Message-ID: <20170608143733.30004-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtdtests module has some useful tests to verify that
mtd drivers like davinci_nand are working correctly.

Enable it in davinci_all_defconfig to make testing and
debug easier.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 7f726277dd1b..1f1b4a795dc6 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -58,6 +58,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
+CONFIG_MTD_TESTS=m
 CONFIG_MTD_BLOCK=m
 CONFIG_MTD_CFI=m
 CONFIG_MTD_CFI_INTELEXT=m
-- 
2.9.0
