From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:27:14 +0900
Subject: [PATCH 03/12] [ARM][S3C6410] Kconfig support for keypad platform
	device
Message-ID: <00a301ca2e2c$94e0ce40$bea26ac0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds configuration name of keypad platform device.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 935c755..400f7d6 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -198,4 +198,9 @@ config S3C_DEV_USB_HSOTG
 	help
 	  Compile in platform device definition for USB high-speed OtG
 
+config S3C_DEV_KEYPAD
+	bool
+	help
+	  Compile in platform device definition for keypad
+
 endif
-- 
1.6.2.5
