From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 26 Sep 2014 11:45:55 +0200
Subject: [PATCH resend] MAINTAINERS: Add maintainers entry for Mediatek SoCs
Message-ID: <1411724755-9866-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I plan to stay with the Mediatek SoCs for the next future
and hope to expand its support along the way with the help
of a whole bunch of people.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65fd4db..2e4a030 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1156,6 +1156,16 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
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
