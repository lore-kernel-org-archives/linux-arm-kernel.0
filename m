From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 06:59:26 -0700
Subject: [PATCH] MAINTAINERS: ARM/Amlogic: add co-maintainer, misc. updates
Message-ID: <1462543166-8065-1-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as co-maintainer, update mailing list entry and add a couple
more directories.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42e65d128d01..31e5043653dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -948,12 +948,15 @@ F:	drivers/clk/sunxi/
 
 ARM/Amlogic Meson SoC support
 M:	Carlo Caione <carlo@caione.org>
+M:	Kevin Hilman <khilman@baylibre.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-L:	linux-meson at googlegroups.com
+L:	linux-amlogic at lists.infradead.org
 W:	http://linux-meson.com/
 S:	Maintained
 F:	arch/arm/mach-meson/
 F:	arch/arm/boot/dts/meson*
+F:	arch/arm64/boot/dts/amlogic/
+F: 	drivers/pinctrl/meson/
 N:	meson
 
 ARM/Annapurna Labs ALPINE ARCHITECTURE
-- 
2.7.4
