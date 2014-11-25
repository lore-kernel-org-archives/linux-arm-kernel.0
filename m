From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 25 Nov 2014 16:24:59 +0100
Subject: [PATCH] ARM: shmobile: kzm9g_defconfig: Update AK8975 config option
Message-ID: <1416929099-29282-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_SENSORS_AK8975 was renamed to CONFIG_AK8975 in commit
2fc72cd8354e3e9c ("iio:magnetometer:ak8975 move driver out of staging")
in v3.10.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/kzm9g_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 8cb115d74fdf4e37..bfe568847503ff5f 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -126,8 +126,8 @@ CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_ASYNC_TX_DMA=y
 CONFIG_STAGING=y
-CONFIG_SENSORS_AK8975=y
 CONFIG_IIO=y
+CONFIG_AK8975=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
1.9.1
