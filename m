From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 30 Jan 2013 17:25:02 +0100
Subject: [PATCH] ARM: ux500: correct typo in pinctrl Device Tree node
Message-ID: <1359563102-5934-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

The preference is to use '-' instead of '_' in compatible strings.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 96f518b..69140ba 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -171,7 +171,7 @@
 		};
 
 		pinctrl {
-			compatible = "stericsson,nmk_pinctrl";
+			compatible = "stericsson,nmk-pinctrl";
 			prcm = <&prcmu>;
 		};
 
-- 
1.7.11.3
