From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Mar 2018 07:16:21 -0700
Subject: [PATCH 4/5] ARM: omap2plus_defconfig: Add UINPUT
In-Reply-To: <20180320141622.77989-1-tony@atomide.com>
References: <20180320141622.77989-1-tony@atomide.com>
Message-ID: <20180320141622.77989-5-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be used for keyboard fn keys with funkeymonkey.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -234,6 +234,7 @@ CONFIG_INPUT_MISC=y
 CONFIG_INPUT_CPCAP_PWRBUTTON=m
 CONFIG_INPUT_TPS65218_PWRBUTTON=m
 CONFIG_INPUT_TWL4030_PWRBUTTON=m
+CONFIG_INPUT_UINPUT=m
 CONFIG_INPUT_PALMAS_PWRBUTTON=m
 CONFIG_INPUT_PWM_VIBRA=m
 CONFIG_SERIO=m
-- 
2.16.2
