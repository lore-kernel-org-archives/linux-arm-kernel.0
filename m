From: tony@atomide.com (Tony Lindgren)
Date: Sun, 22 Oct 2017 14:21:10 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Enable droid 4 USB PHY
Message-ID: <20171022212110.9674-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's enable this as loadable module for droid 4.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -475,6 +475,7 @@ CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_TWL=m
 CONFIG_PWM_TWL_LED=m
+CONFIG_PHY_CPCAP_USB=m
 CONFIG_PHY_DM816X_USB=m
 CONFIG_OMAP_USB2=m
 CONFIG_TI_PIPE3=y
-- 
2.14.2
