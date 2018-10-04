From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Oct 2018 19:40:38 +0800
Subject: [PATCH] MAINTAINERS: update entry for Mediatek pin controller
Message-ID: <98b17a3b47f75d4f3f17dae81a087b4163fcd857.1538652946.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add all source files under drivers/pinctrl/mediatek for the entry and
change the address to a permanent one since I have a personal leave
over the next few months and the address would be suspended for a while.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@kernel.org>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a692e..bc0e03a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11654,15 +11654,12 @@ S:	Maintained
 F:	drivers/pinctrl/intel/
 
 PIN CONTROLLER - MEDIATEK
-M:	Sean Wang <sean.wang@mediatek.com>
+M:	Sean Wang <sean.wang@kernel.org>
 L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
-F:	drivers/pinctrl/mediatek/mtk-eint.*
-F:	drivers/pinctrl/mediatek/pinctrl-mtk-common.*
-F:	drivers/pinctrl/mediatek/pinctrl-mt2701.c
-F:	drivers/pinctrl/mediatek/pinctrl-mt7622.c
+F:	drivers/pinctrl/mediatek/
 
 PIN CONTROLLER - QUALCOMM
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
-- 
2.7.4
