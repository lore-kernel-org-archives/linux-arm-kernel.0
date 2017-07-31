From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:02:59 +0200
Subject: [PATCH 07/31] arm64: dts: ulcb: Enable I2C4
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <476b2e4f71542e9ea61f6eb856a040495c665a07.1501509525.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>

This enables I2C4 for ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 84b4daddced0..0467cd051710 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -189,6 +189,12 @@
 	};
 };
 
+&i2c4 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+};
+
 &i2c_dvfs {
 	status = "okay";
 };
-- 
2.1.4
