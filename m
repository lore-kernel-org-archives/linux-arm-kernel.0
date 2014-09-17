From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 17 Sep 2014 15:50:31 +0200
Subject: [PATCH] MAINTAINERS: Add maintainers entry for Mediatek SoCs
Message-ID: <1410961831-15532-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I plan to stay with the Mediatek SoCs for the near future
and hope to expand its support along the way with the help
of a whole bunch of people.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63c1b0f..23618e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1162,6 +1162,16 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
 S:	Maintained
 F:	arch/arm/mach-orion5x/ts78xx-*
 
+ARM/Mediatek SoC support
+M:	Matthias Brugger <matthias.bgg@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/mt6*
+F:	arch/arm/boot/dts/mt8*
+F:	arch/arm/mach-mediatek/
+N:	mtk
+K:	mediatek
+
 ARM/MICREL KS8695 ARCHITECTURE
 M:	Greg Ungerer <gerg@uclinux.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.9.1
