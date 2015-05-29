From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 May 2015 10:12:12 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Add dm816x USB PHY as a loadable
 module
Message-ID: <1432919532-20445-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for USB on dm816x-evm.

Cc: Bin Liu <binmlist@gmail.com>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: George Cherian <george.cherian@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 4380291..92e4206 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -402,6 +402,7 @@ CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_TWL=m
 CONFIG_PWM_TWL_LED=m
+CONFIG_PHY_DM816X_USB=m
 CONFIG_OMAP_USB2=m
 CONFIG_TI_PIPE3=y
 CONFIG_TWL4030_USB=m
-- 
2.1.4
