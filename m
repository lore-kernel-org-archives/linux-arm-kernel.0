From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 14 Nov 2017 22:41:14 +0100
Subject: [PATCH 8/8] MAINTAINERS: update Mediatek Soc entry
In-Reply-To: <20171114214114.15793-1-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
Message-ID: <20171114214114.15793-9-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek SoCs include several soc specific drivers as well
as a mfd device. Add these to the maintainers file.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2811a211632c..586797908865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1606,6 +1606,8 @@ F:	arch/arm/boot/dts/mt7*
 F:	arch/arm/boot/dts/mt8*
 F:	arch/arm/mach-mediatek/
 F:	arch/arm64/boot/dts/mediatek/
+F:	drivers/soc/mediatek/
+F:	drivers/mfd/mtk-mmsys.c
 N:	mtk
 K:	mediatek
 
-- 
2.14.2
