From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  9 Jul 2015 17:43:15 +0200
Subject: [PATCH 2/3] ARM: ep93xx: add DMA engine to the defconfig
Message-ID: <1436456595-4915-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several boards can make use of the DMA engine on the EP93xx
so let's enable this by default in the defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/ep93xx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 2ca11ce504c7..e684386e97ba 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -109,6 +109,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_M48T86=y
 CONFIG_RTC_DRV_EP93XX=y
+CONFIG_DMADEVICES=y
+CONFIG_EP93XX_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
2.4.3
