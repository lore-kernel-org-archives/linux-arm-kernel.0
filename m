From: rick.chang@mediatek.com (Rick Chang)
Date: Tue, 22 Nov 2016 11:46:17 +0800
Subject: [PATCH v7 4/4] vcodec: mediatek: Add Maintainers entry for Mediatek
 JPEG driver
In-Reply-To: <1479786377-11567-1-git-send-email-rick.chang@mediatek.com>
References: <1479786377-11567-1-git-send-email-rick.chang@mediatek.com>
Message-ID: <1479786377-11567-5-git-send-email-rick.chang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rick Chang <rick.chang@mediatek.com>
Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93e9f42..a9e7ee0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7818,6 +7818,13 @@ L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/mediatek/
 
+MEDIATEK JPEG DRIVER
+M:	Rick Chang <rick.chang@mediatek.com>
+M:	Minghsiu Tsai <minghsiu.tsai@mediatek.com>
+S:	Supported
+F:	drivers/media/platform/mtk-jpeg/
+F:	Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
+
 MEDIATEK MEDIA DRIVER
 M:	Tiffany Lin <tiffany.lin@mediatek.com>
 M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
-- 
1.9.1
