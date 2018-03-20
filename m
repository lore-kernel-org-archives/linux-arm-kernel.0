From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Mar 2018 07:16:18 -0700
Subject: [PATCH 1/5] ARM: omap2plus_defconfig: Enable PWM_VIBRA
In-Reply-To: <20180320141622.77989-1-tony@atomide.com>
References: <20180320141622.77989-1-tony@atomide.com>
Message-ID: <20180320141622.77989-2-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use PWM_VIBRA on many phones like droid 4.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -235,6 +235,7 @@ CONFIG_INPUT_CPCAP_PWRBUTTON=m
 CONFIG_INPUT_TPS65218_PWRBUTTON=m
 CONFIG_INPUT_TWL4030_PWRBUTTON=m
 CONFIG_INPUT_PALMAS_PWRBUTTON=m
+CONFIG_INPUT_PWM_VIBRA=m
 CONFIG_SERIO=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
-- 
2.16.2
