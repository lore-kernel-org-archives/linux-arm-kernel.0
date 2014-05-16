From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:28 +0900
Subject: [PATCH 03/12] ARM: shmobile: r7s72100: genmai: populate nodes for
 external clocks
In-Reply-To: <cover.1400201383.git.horms+renesas@verge.net.au>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
Message-ID: <5f76a5699f52052468e006e6c58010c5183b8386.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index e664611..941e72c 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -30,6 +30,14 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <13330000>;
+};
+
+&usb_x1_clk {
+	clock-frequency = <48000000>;
+};
+
 &i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
1.8.5.2
