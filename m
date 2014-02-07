From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 7 Feb 2014 15:51:23 +0530
Subject: [PATCH V2 1/4] ARM: OMAP2+: AM43x: enable in default config
In-Reply-To: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
References: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1391768486-2134-2-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Afzal Mohammed <afzal@ti.com>

Enable AM43x SoC in omap2plus_defconfig

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3a0b53d..364ba38 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -28,6 +28,7 @@ CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
 CONFIG_SOC_AM33XX=y
+CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
-- 
1.7.9.5
