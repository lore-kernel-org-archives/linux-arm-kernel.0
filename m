From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Mar 2018 07:16:20 -0700
Subject: [PATCH 3/5] ARM: omap2plus_defconfig: Enable MDM6600 USB PHY
In-Reply-To: <20180320141622.77989-1-tony@atomide.com>
References: <20180320141622.77989-1-tony@atomide.com>
Message-ID: <20180320141622.77989-4-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows droid 4 USB modem to work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -500,6 +500,7 @@ CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_TWL=m
 CONFIG_PWM_TWL_LED=m
 CONFIG_PHY_CPCAP_USB=m
+CONFIG_PHY_MAPPHONE_MDM6600=m
 CONFIG_PHY_DM816X_USB=m
 CONFIG_OMAP_USB2=m
 CONFIG_TI_PIPE3=y
-- 
2.16.2
