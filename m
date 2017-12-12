From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 12 Dec 2017 14:24:21 +0800
Subject: [PATCH v2 4/4] pinctrl: mediatek: update MAINTAINERS entry with
 MediaTek pinctrl driver
In-Reply-To: <cover.1513059081.git.sean.wang@mediatek.com>
References: <cover.1513059081.git.sean.wang@mediatek.com>
Message-ID: <d41feb63ea2ebbfe58f5940ff27b031dd8024b28.1513059082.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

I work for MediaTek on maintaining the existing MediaTek SoC whose target
to home gateway such as MT7622 and MT7623 that is reusing MT2701 related
files and will keep adding support for the following such kinds of SoCs
in the future.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Biao Huang <biao.huang@mediatek.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52f..c0edf30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10773,6 +10773,16 @@ M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 S:	Maintained
 F:	drivers/pinctrl/intel/
 
+PIN CONTROLLER - MEDIATEK
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
+F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
+F:	drivers/pinctrl/mediatek/pinctrl-mtk-common.*
+F:	drivers/pinctrl/mediatek/pinctrl-mt2701.c
+F:	drivers/pinctrl/mediatek/pinctrl-mt7622.c
+
 PIN CONTROLLER - QUALCOMM
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 S:	Maintained
-- 
2.7.4
