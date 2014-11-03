From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 3 Nov 2014 10:28:11 +0800
Subject: [PATCH] pinctrl: Fix path error in documentation
Message-ID: <1414981691-14087-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix pinconfig include file path.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index 98eb94d..47d84b6 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -216,4 +216,4 @@ arguments are described below.
   or 0 to disable debouncing
 
 More in-depth documentation on these parameters can be found in
-<include/linux/pinctrl/pinconfig-generic.h>
+<include/linux/pinctrl/pinconf-generic.h>
-- 
1.8.1.1.dirty
