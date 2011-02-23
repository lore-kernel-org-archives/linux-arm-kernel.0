From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 23 Feb 2011 16:06:55 +0800
Subject: [PATCH] ARM: mx51_defconfig: change CONFIG_LEDS_CLASS 'm' to 'y'
Message-ID: <1298448415-21986-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to fix the warning below.

arch/arm/configs/mx51_defconfig:113:warning: symbol value 'm' invalid for LEDS_CLASS

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
This warning bothers me for quite some time.  I'm unsure if this is
the right fix, and I just want to draw people's attention with this
patch.

 arch/arm/configs/mx51_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index 9cba68c..e3c9032 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -110,7 +110,7 @@ CONFIG_MMC=y
 CONFIG_MMC_BLOCK=m
 CONFIG_MMC_SDHCI=m
 CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_CLASS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_EXT2_FS=y
-- 
1.7.1
