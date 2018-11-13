From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 13 Nov 2018 15:01:17 +0100
Subject: [PATCH v2 09/25] ARM: davinci: da850-evm: remove unnecessary include
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Message-ID: <20181113140133.17385-10-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The include file for at24_platform_data is not needed in this file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index bac2162e2153..6a29baf0a289 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/platform_data/pca953x.h>
 #include <linux/input.h>
 #include <linux/input/tps6507x-ts.h>
-- 
2.19.1
