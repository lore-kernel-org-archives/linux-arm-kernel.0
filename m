From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue,  4 Apr 2017 11:30:36 -0400
Subject: [PATCH v4 8/8] ARM: ux500: Add vendor prefix to tps61052 node
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Message-ID: <20170404153036.6651-9-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tps61052 device node doesn't have a vendor prefix
in its compatible string, fix it by adding one.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

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
