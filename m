From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:50 +0200
Subject: [PATCH 38/38] ARM: dts: iwg20m: Correct indentation of mmcif0
 properties
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <bf38b9ac16c5c8a82d63c79391dd64c5924fc00b.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: 4658c4b789d8e2ae ("ARM: dts: iwg20m: Add MMCIF0 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index f78dbc542a82..ff7993818637 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -45,11 +45,11 @@
 };
 
 &mmcif0 {
-		pinctrl-0 = <&mmcif0_pins>;
-		pinctrl-names = "default";
+	pinctrl-0 = <&mmcif0_pins>;
+	pinctrl-names = "default";
 
-		vmmc-supply = <&reg_3p3v>;
-		bus-width = <8>;
-		non-removable;
-		status = "okay";
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
 };
-- 
2.1.4
