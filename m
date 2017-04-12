From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 12 Apr 2017 14:27:59 -0300
Subject: [PATCH v5 8/8] ARM: ux500: Add vendor prefix to tps61052 node
In-Reply-To: <20170412172800.23035-1-javier@osg.samsung.com>
References: <20170412172800.23035-1-javier@osg.samsung.com>
Message-ID: <20170412172800.23035-9-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tps61052 device node doesn't have a vendor prefix
in its compatible string, fix it by adding one.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>

---

Changes in v5:
- Add Rob Herring's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/ste-hrefprev60.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 5882a2606ac3..3f14b4df69b4 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -30,7 +30,7 @@
 
 		i2c at 80004000 {
 			tps61052 at 33 {
-				compatible = "tps61052";
+				compatible = "ti,tps61052";
 				reg = <0x33>;
 			};
 
-- 
2.9.3
