From: nm@ti.com (Nishanth Menon)
Date: Mon, 7 Oct 2013 11:49:43 -0500
Subject: [PATCH 2/2] ARM: dts: omap3-beagle: use 3630 definitions
In-Reply-To: <1381164584-4008-1-git-send-email-nm@ti.com>
References: <523C9D8B.2000701@ti.com>
 <1381164584-4008-1-git-send-email-nm@ti.com>
Message-ID: <1381164584-4008-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

beagle-xm currently would matchup with ti,omap3 which invokes
omap3430_init_early instead of omap3630_init_early. So add
compatiblity for 3630 to allow match

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 0f7cfc5..2079e22 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard xM";
-	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";
+	compatible = "ti,omap3-beagle-xm", "ti,omap363x", "ti,omap3-beagle", "ti,omap3";
 
 	cpus {
 		cpu at 0 {
-- 
1.7.9.5
