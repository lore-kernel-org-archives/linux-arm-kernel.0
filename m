From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Dec 2013 18:26:00 +0100
Subject: [PATCH 5/5] ARM: versatile: enable LEDs by default
Message-ID: <1387560360-21574-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the LEDs and triggers used by the Versatile boards to
the default configuration.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/versatile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 6d4c2df44c9c..073541a50e23 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -60,6 +60,9 @@ CONFIG_SND_PCM_OSS=m
 CONFIG_SND_ARMAACI=m
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_VFAT_FS=m
 CONFIG_JFFS2_FS=y
-- 
1.8.3.1
