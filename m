From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 25 Apr 2018 17:32:42 +0800
Subject: [PATCH v2 16/17] MAINTAINERS: update entry for ARM/Mediatek RTC DRIVER
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
Message-ID: <39a73c162a637e1558e8c00a971db5db569397ff.1524646231.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add new files for new dt-bindings and a globally visible header file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d..a7ef37f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1607,9 +1607,11 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 F:	Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
 F:	drivers/rtc/rtc-mt6397.c
 F:	drivers/rtc/rtc-mt7622.c
+F:	include/linux/mfd/mt6397/rtc.h
 
 ARM/Mediatek SoC support
 M:	Matthias Brugger <matthias.bgg@gmail.com>
-- 
2.7.4
