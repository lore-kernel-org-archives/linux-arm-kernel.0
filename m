From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 15 Jun 2017 20:49:28 +0200
Subject: [RESEND PATCH v6 8/8] ARM: ux500: Add vendor prefix to tps61052 node
In-Reply-To: <20170615184928.12007-1-javier@dowhile0.org>
References: <20170615184928.12007-1-javier@dowhile0.org>
Message-ID: <20170615184928.12007-9-javier@dowhile0.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tps61052 device node doesn't have a vendor prefix
in its compatible string, fix it by adding one.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>


---

Changes in v6: None
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
