From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:27:14 +0900
Subject: [PATCH 05/12] [ARM][S3C6410] extern definition support for keypad
	platform device
Message-ID: <00a101ca2e2c$94bd19a0$be374ce0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes extern definition of keypad platform device.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/devs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/devs.h b/arch/arm/plat-s3c/include/plat/devs.h
index 2e17082..dd16329 100644
--- a/arch/arm/plat-s3c/include/plat/devs.h
+++ b/arch/arm/plat-s3c/include/plat/devs.h
@@ -42,6 +42,7 @@ extern struct platform_device s3c_device_hwmon;
 extern struct platform_device s3c_device_hsmmc0;
 extern struct platform_device s3c_device_hsmmc1;
 extern struct platform_device s3c_device_hsmmc2;
+extern struct platform_device s3c_device_keypad;
 
 extern struct platform_device s3c_device_spi0;
 extern struct platform_device s3c_device_spi1;
-- 
1.6.2.5
