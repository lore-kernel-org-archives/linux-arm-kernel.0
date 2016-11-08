From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  8 Nov 2016 10:27:17 +0100
Subject: [PATCH] pinctrl: sx150x: fix up headers
Message-ID: <1478597237-4441-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include <linux/gpio/driver.h> rather than <linux/gpio.h>
Drop <linux/pinctrl/machine.h>.

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-sx150x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index dc1341fdc73d..63778058eec7 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -27,8 +27,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/gpio.h>
-#include <linux/pinctrl/machine.h>
+#include <linux/gpio/driver.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-- 
2.7.4
