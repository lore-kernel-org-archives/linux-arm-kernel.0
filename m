From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 3 Aug 2017 16:37:19 +0800
Subject: [PATCH 2/2] MAINTAINERS: add entry for mediatek usb3 DRD IP driver
In-Reply-To: <1501749439-8837-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1501749439-8837-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1501749439-8837-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer of MediaTek USB3 DRD IP driver

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205d397..0f0bcc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8472,6 +8472,13 @@ M:      Sean Wang <sean.wang@mediatek.com>
 S:      Maintained
 F:      drivers/char/hw_random/mtk-rng.c
 
+MEDIATEK USB3 DRD IP DRIVER
+M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/usb/mtu3/
+
 MEGACHIPS STDPXXXX-GE-B850V3-FW LVDS/DP++ BRIDGES
 M:	Peter Senna Tschudin <peter.senna@collabora.com>
 M:	Martin Donnelly <martin.donnelly@ge.com>
-- 
1.7.9.5
