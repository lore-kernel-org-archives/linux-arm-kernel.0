From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Dec 2012 16:25:15 +0100
Subject: [PATCH] ARM: sunxi: Change dtsi naming scheme for sun5i
Message-ID: <1355325915-22375-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is several different SoCs sharing the sun5i codename: A10s, A12
and A13. Since there is enough differences to not consider those the
same SoCs, change a bit the naming scheme to reflect this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/{sun5i.dtsi => sun5i-a13.dtsi} |    0
 arch/arm/boot/dts/sun5i-olinuxino.dts            |    4 ++--
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{sun5i.dtsi => sun5i-a13.dtsi} (100%)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sun5i.dtsi
rename to arch/arm/boot/dts/sun5i-a13.dtsi
diff --git a/arch/arm/boot/dts/sun5i-olinuxino.dts b/arch/arm/boot/dts/sun5i-olinuxino.dts
index d6ff889..498a091 100644
--- a/arch/arm/boot/dts/sun5i-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-olinuxino.dts
@@ -12,11 +12,11 @@
  */
 
 /dts-v1/;
-/include/ "sun5i.dtsi"
+/include/ "sun5i-a13.dtsi"
 
 / {
 	model = "Olimex A13-Olinuxino";
-	compatible = "olimex,a13-olinuxino", "allwinner,sun5i";
+	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
 
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
-- 
1.7.9.5
