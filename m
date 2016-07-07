From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Jul 2016 16:39:44 +0200
Subject: [PATCH 1/8] arm64: dts: r8a7795: Add missing blank lines between cpu
 nodes
In-Reply-To: <cover.1467900241.git.horms+renesas@verge.net.au>
References: <cover.1467900241.git.horms+renesas@verge.net.au>
Message-ID: <a5547642a4e08c98edeaf4b62f6da0ac8ed2f6bd.1467900241.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

For consistency with a57_0/a57_1 cpu nodes, and all other nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 04eb0bc65634..fad6dd8b7771 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -53,6 +53,7 @@
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
+
 		a57_2: cpu at 2 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x2>;
@@ -61,6 +62,7 @@
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
+
 		a57_3: cpu at 3 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x3>;
-- 
2.7.0.rc3.207.g0ac5344
