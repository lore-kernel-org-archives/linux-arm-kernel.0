From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:13 +0100
Subject: [PATCH 02/32] arm64: dts: r8a7796: salvator-x: Add I2C for DVFS
 device support
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <d8e62f0729bb404caa6ba42b65d5a1e4d370a6e3.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

This patch adds support of I2C for DVFS device for Salvator-X board on
R8A7796 SoC.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index c7f40f8f3169..61f4662db497 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -261,3 +261,7 @@
 	timeout-sec = <60>;
 	status = "okay";
 };
+
+&i2c_dvfs {
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
