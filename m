From: nm@ti.com (Nishanth Menon)
Date: Tue, 21 Oct 2014 09:24:22 -0500
Subject: [PATCH] MAINTAINERS: Update entry for omap related .dts files to
 cover new SoCs
Message-ID: <1413901462-32181-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7(including AM5x) and AM47x series are handled under OMAP umbrella.
These SoC support and dts have been added since 3.14 kernel and Pull
requests for these have come in from OMAP till date.

So just ensure that get_maintainers can pick up this list as well.

Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Cc: devicetree at vger.kernel.org
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 MAINTAINERS |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9b..e205bd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6585,6 +6585,9 @@ L:	devicetree at vger.kernel.org
 S:	Maintained
 F:	arch/arm/boot/dts/*omap*
 F:	arch/arm/boot/dts/*am3*
+F:	arch/arm/boot/dts/*am4*
+F:	arch/arm/boot/dts/*am5*
+F:	arch/arm/boot/dts/*dra7*
 
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
-- 
1.7.9.5
