From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 1 Dec 2015 09:35:45 -0200
Subject: [PATCH v2] multi_v7_defconfig: Remove CONFIG_SOC_LS1021A
Message-ID: <1448969745-19743-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

multi_v7_defconfig is not suitable for booting LS1021 as it needs
LPAE.
    
Remove this option.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Improve commit log

 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fa7ba92..410a699 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -54,7 +54,6 @@ CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
 CONFIG_SOC_VF610=y
-CONFIG_SOC_LS1021A=y
 CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
-- 
1.9.1
