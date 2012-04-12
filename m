From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 12 Apr 2012 19:51:44 +0200
Subject: [PATCH] pinctrl: mark non-EXPERIMENTAL
Message-ID: <1334253104-30527-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

With the finalization of the external driver API and the device
tree support, this subsystem is now mature and can be promoted to
non-experimental status.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index abfb964..f73a5ea 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -4,7 +4,6 @@
 
 config PINCTRL
 	bool
-	depends on EXPERIMENTAL
 
 if PINCTRL
 
-- 
1.7.9.2
