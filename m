From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 28 May 2015 21:57:23 +0900
Subject: [PATCH] pinctrl: zynq: add static to zynq_pins
Message-ID: <1432817843-6038-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This array is only referenced in this file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 0ff653c..a687f24 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -123,7 +123,7 @@ enum zynq_pinmux_functions {
 	ZYNQ_PMUX_MAX_FUNC
 };
 
-const struct pinctrl_pin_desc zynq_pins[] = {
+static const struct pinctrl_pin_desc zynq_pins[] = {
 	PINCTRL_PIN(0,  "MIO0"),
 	PINCTRL_PIN(1,  "MIO1"),
 	PINCTRL_PIN(2,  "MIO2"),
-- 
1.9.1
