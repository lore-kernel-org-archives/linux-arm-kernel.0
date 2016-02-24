From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 24 Feb 2016 16:04:50 +0100
Subject: [PATCH 1/2] ARM: mxs_defconfig: Cleanup mxs_defconfig
Message-ID: <1456326291-20618-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

Regenerate mxs_defconfig by running:
make mxs_defconfig
make savedefconfig
mv defconfig arch/arm/configs/mxs_defconfig

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/configs/mxs_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index b47e7c6..5e7b7df 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -144,7 +144,6 @@ CONFIG_PWM_MXS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_FSCACHE=m
 CONFIG_FSCACHE_STATS=y
@@ -178,7 +177,6 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_USER=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_MXS_DCP=y
 CONFIG_CRC_ITU_T=m
 CONFIG_CRC7=m
-- 
2.7.0
