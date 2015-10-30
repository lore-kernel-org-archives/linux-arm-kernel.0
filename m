From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Oct 2015 15:06:13 +0100
Subject: [PATCH] pinctrl: zynq: fix UTF-8 errors
Message-ID: <1446213973-4999-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix up S?ren's name in the Zynq driver. I caused this. I fix it.

Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-zynq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 9aefc608ba79..d57b5eca7b98 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2014 Xilinx
  *
- *  S??ren Brinkmann <soren.brinkmann@xilinx.com>
+ *  S?ren Brinkmann <soren.brinkmann@xilinx.com>
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1242,6 +1242,6 @@ static void __exit zynq_pinctrl_exit(void)
 }
 module_exit(zynq_pinctrl_exit);
 
-MODULE_AUTHOR("S??ren Brinkmann <soren.brinkmann@xilinx.com>");
+MODULE_AUTHOR("S?ren Brinkmann <soren.brinkmann@xilinx.com>");
 MODULE_DESCRIPTION("Xilinx Zynq pinctrl driver");
 MODULE_LICENSE("GPL");
-- 
2.4.3
