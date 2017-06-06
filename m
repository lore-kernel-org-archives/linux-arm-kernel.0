From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:22 +0200
Subject: [PATCH v4 24/28] MAINTAINERS: Update Actions Semi section with SPS
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-25-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add file patterns to cover the SPS power domain driver and DT binding.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4: new
 
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a9faa30def9c..1bfd357f5279 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1044,7 +1044,10 @@ N:	owl
 F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/s500*
 F:	arch/arm64/boot/dts/actions/
+F:	drivers/soc/actions/
+F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 
 ARM/ADS SPHERE MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
2.12.3
