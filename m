From: tony@atomide.com (Tony Lindgren)
Date: Thu,  1 Mar 2018 14:16:57 -0800
Subject: [PATCH 03/10] ARM: omap2plus_defconfig: Select MFD_TI_LMU
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Message-ID: <20180301221704.104530-4-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have REGULATOR_LM363X selected but not MFD_TI_LMU and
REGULATOR_LM363X depends on MFD_TI_LMU.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -295,6 +295,7 @@ CONFIG_OMAP_WATCHDOG=m
 CONFIG_TWL4030_WATCHDOG=m
 CONFIG_MFD_CPCAP=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
+CONFIG_MFD_TI_LMU=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TI_LP873X=y
-- 
2.16.2
