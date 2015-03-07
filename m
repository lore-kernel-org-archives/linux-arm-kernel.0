From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat,  7 Mar 2015 16:14:22 +0100
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable ChromeOS EC chardev driver
Message-ID: <1425741262-8278-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos Chromebooks have an Embedded Controller known as the ChromeOS EC
Enable the driver that provides an interface to access from user-space.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 3d22aae39a83..14fa9f05f768 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -173,6 +173,8 @@ CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC_CHARDEV=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=y
 CONFIG_COMMON_CLK_S2MPS11=y
-- 
2.1.4
