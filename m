From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Oct 2010 18:23:14 +0100
Subject: [PATCH 1/2] S3C64XX: Ensure samsung_keypad_cfg_gpio() is prototyped
Message-ID: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it's exported we should make sure we're using the prototype
others see.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/setup-keypad.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c64xx/setup-keypad.c
index d1fd722..f8ed0d2 100644
--- a/arch/arm/mach-s3c64xx/setup-keypad.c
+++ b/arch/arm/mach-s3c64xx/setup-keypad.c
@@ -12,6 +12,7 @@
 
 #include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
+#include <plat/keypad.h>
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
-- 
1.7.1
