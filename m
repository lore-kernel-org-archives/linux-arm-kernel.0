From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 19 Jun 2017 05:44:07 +0200
Subject: [PATCH v5 22/26] MAINTAINERS: Update Actions Semi section with SPS
In-Reply-To: <20170606005426.26446-25-afaerber@suse.de>
References: <20170606005426.26446-25-afaerber@suse.de>
Message-ID: <20170619034407.5942-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add file patterns to cover the SPS power domain driver and DT binding.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4 -> v5:
 * Rebased onto timer additions
 * Added dt-bindings header file pattern
 
 v4: new
 
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 831bfd5cc68b..eb62d294095e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1045,7 +1045,11 @@ F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/soc/actions/
+F:	include/dt-bindings/power/owl-*
+F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 
 ARM/ADS SPHERE MACHINE SUPPORT
-- 
2.12.3
