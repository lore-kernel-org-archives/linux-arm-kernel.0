From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 30 Jun 2017 14:03:07 +0800
Subject: [PATCH v1 4/4] MAINTAINERS: add entry for MediaTek CIR driver
In-Reply-To: <cover.1498794408.git.sean.wang@mediatek.com>
References: <cover.1498794408.git.sean.wang@mediatek.com>
Message-ID: <66add79b9e331edfbf3a797cb3fcbcf3fd119eb2.1498794408.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

I work for MediaTek on maintaining the MediaTek CIR driver
for the existing SoCs and adding support for the following
SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a1290a..1bc1fb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8261,6 +8261,11 @@ L:	linux-wireless at vger.kernel.org
 S:	Maintained
 F:	drivers/net/wireless/mediatek/mt7601u/
 
+MEDIATEK CIR DRIVER
+M:      Sean Wang <sean.wang@mediatek.com>
+S:      Maintained
+F:      drivers/media/rc/mtk-cir.c
+
 MEDIATEK RANDOM NUMBER GENERATOR SUPPORT
 M:      Sean Wang <sean.wang@mediatek.com>
 S:      Maintained
-- 
2.7.4
