From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 13:00:01 -0700
Subject: [PATCH 1/3] ARM: omap2plus_defconfig: Enable leds-pwm
In-Reply-To: <1426536003-7077-1-git-send-email-tony@atomide.com>
References: <1426536003-7077-1-git-send-email-tony@atomide.com>
Message-ID: <1426536003-7077-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used on many omap boards.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 4e3e93d..df41f2c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -348,6 +348,7 @@ CONFIG_MMC_OMAP_HS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_GPIO=m
+CONFIG_LEDS_PWM=m
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_ONESHOT=m
-- 
2.1.4
