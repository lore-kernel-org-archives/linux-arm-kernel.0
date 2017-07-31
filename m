From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:02:58 +0200
Subject: [PATCH 06/31] arm64: dts: ulcb: Enable I2C for DVFS device
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <a4fedb3a4ab9ed9d602e049213bc2a96003ebc46.1501509525.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>

This enables I2C for DVFS device for ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index b5c6ee07d7f9..84b4daddced0 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -189,6 +189,10 @@
 	};
 };
 
+&i2c_dvfs {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.1.4
