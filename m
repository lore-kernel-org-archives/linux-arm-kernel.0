From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 18:33:03 +0100
Subject: [PATCH 5/8] arm: mxs: Enable EXT2 and EXT4
In-Reply-To: <1355938386-14582-1-git-send-email-marex@denx.de>
References: <1355938386-14582-1-git-send-email-marex@denx.de>
Message-ID: <1355938386-14582-6-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These filesystems are really basic. Enable them by default.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 41b5a74..9c2d11d 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -132,7 +132,10 @@ CONFIG_COMMON_CLK_DEBUG=y
 CONFIG_IIO=y
 CONFIG_PWM=y
 CONFIG_PWM_MXS=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_FSCACHE=m
 CONFIG_FSCACHE_STATS=y
@@ -161,7 +164,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_CRC32C=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_ITU_T=m
-- 
1.7.10.4
