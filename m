From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 25 May 2012 21:36:15 +0800
Subject: [PATCH v4 1/6] gpio: fix a typo of comment message
Message-ID: <1337952980-14621-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/gpio/gpiolib-of.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index d18068a..8389d4a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -21,7 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
 
-/* Private data structure for of_gpiochip_is_match */
+/* Private data structure for of_gpiochip_find_and_xlate */
 struct gg_data {
 	enum of_gpio_flags *flags;
 	struct of_phandle_args gpiospec;
-- 
1.7.0.4
