From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:27:14 +0900
Subject: [PATCH 04/12] [ARM][S3C6410] Makefile support for keypad platform
	device
Message-ID: <00a201ca2e2c$94cdbb70$be693250$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports to compile of keypad platform device.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 0761766..7cc9055 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_SND_S3C64XX_SOC_I2S)	+= dev-audio.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
+obj-$(CONFIG_S3C_DEV_KEYPAD)	+= dev-keypad.o
-- 
1.6.2.5
