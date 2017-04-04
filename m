From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue,  4 Apr 2017 11:30:32 -0400
Subject: [PATCH v4 4/8] ARM: dts: n8x0: Add vendor prefix to retu node
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Message-ID: <20170404153036.6651-5-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The retu device node doesn't have a vendor prefix
in its compatible string, fix it by adding one.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 1b06430c8013..91886231e5a8 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -16,7 +16,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			retu: retu at 1 {
-				compatible = "retu";
+				compatible = "nokia,retu";
 				interrupt-parent = <&gpio4>;
 				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
 				reg = <0x1>;
-- 
2.9.3
