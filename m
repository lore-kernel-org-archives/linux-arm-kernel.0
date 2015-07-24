From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:23 +0900
Subject: [PATCH 2/9] ARM: shmobile: emev2: kzm9d: enable IIC busses
In-Reply-To: <cover.1437724902.git.horms+renesas@verge.net.au>
References: <cover.1437724902.git.horms+renesas@verge.net.au>
Message-ID: <c53b0c92a829fe804f2f5f749ebc907658ebcf75.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 1dee0aa4f40c..955c24ee4a8c 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -95,6 +95,14 @@
 	};
 };
 
+&iic0 {
+	status = "okay";
+};
+
+&iic1 {
+	status = "okay";
+};
+
 &pfc {
 	uart1_pins: serial at e1030000 {
 		renesas,groups = "uart1_ctrl", "uart1_data";
-- 
2.1.4
