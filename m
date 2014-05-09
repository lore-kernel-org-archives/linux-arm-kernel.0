From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Fri,  9 May 2014 12:27:47 +0530
Subject: [PATCH v3 1/3] ARM: integrator: drop CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <1399618669-6830-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1399618669-6830-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1399618669-6830-2-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch drops CONFIG_COMMON_CLK_DEBUG option
as this config option is now obsolete.

CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/configs/integrator_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 5bae195..c1f5adc 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -73,7 +73,6 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL030=y
-CONFIG_COMMON_CLK_DEBUG=y
 CONFIG_EXT2_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
1.7.9.5
