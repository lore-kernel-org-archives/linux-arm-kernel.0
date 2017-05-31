From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 1 Jun 2017 02:44:16 +0800
Subject: [PATCH 4/4] MAINTAINERS: add entry for MediaTek Random Number
 Generator
In-Reply-To: <cover.1496255334.git.sean.wang@mediatek.com>
References: <cover.1496255334.git.sean.wang@mediatek.com>
Message-ID: <896100e7f54d7bf1e1c4926ec5b63b27b99e4890.1496255334.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

I work for MediaTek on maintaining the MediaTek RNG driver
for the existing SoCs and adding support for the following
SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf86519..da473d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8262,6 +8262,11 @@ L:	linux-wireless at vger.kernel.org
 S:	Maintained
 F:	drivers/net/wireless/mediatek/mt7601u/
 
+MEDIATEK RANDOM NUMBER GENERATOR SUPPORT
+M:      Sean Wang <sean.wang@mediatek.com>
+S:      Maintained
+F:      drivers/char/hw_random/mtk-rng.c
+
 MEGACHIPS STDPXXXX-GE-B850V3-FW LVDS/DP++ BRIDGES
 M:	Peter Senna Tschudin <peter.senna@collabora.com>
 M:	Martin Donnelly <martin.donnelly@ge.com>
-- 
1.9.1
