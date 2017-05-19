From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 19 May 2017 13:45:39 +0530
Subject: [PATCH 39/41] ARM: omap2plus_defconfig: Enable PINCTRL_TI_IODELAY
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Message-ID: <20170519081541.26753-40-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PINCTRL_TI_IODELAY since it is required for MMC module in
DRA7 family of processors to configure "IODelay" values
depending on the enumerated MMC modes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a120ae816260..4d92f308349f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -246,6 +246,7 @@ CONFIG_HSI=m
 CONFIG_OMAP_SSI=m
 CONFIG_SSI_PROTOCOL=m
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_TI_IODELAY=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=m
-- 
2.11.0
