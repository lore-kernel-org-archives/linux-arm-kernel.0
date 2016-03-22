From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 22 Mar 2016 12:07:37 +0530
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Enable GPIO_TPIC2810
In-Reply-To: <1458628657-30468-1-git-send-email-lokeshvutla@ti.com>
References: <1458628657-30468-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1458628657-30468-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the TI TPIC2810 8-Bit LED Driver with I2C Interface. This is used
in AM335x ICEv2 Boards.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 156bc88..b4f17a4c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -245,6 +245,7 @@ CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=m
 CONFIG_GPIO_PCF857X=y
+CONFIG_GPIO_TPIC2810=m
 CONFIG_GPIO_TWL4030=y
 CONFIG_GPIO_PALMAS=y
 CONFIG_W1=m
-- 
2.1.4
