From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:06:44 +1000
Subject: [PATCH 2/4] arm64: dts: r8a7795: enable PCIe on Salvator-X
In-Reply-To: <cover.1461723181.git.horms+renesas@verge.net.au>
References: <cover.1461723181.git.horms+renesas@verge.net.au>
Message-ID: <bbd273047b765b431411103c2f7a2688b7288c85.1461723181.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Edworthy <Phil.Edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index b992b1a3d956..7c40ac8232f3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -388,3 +388,15 @@
 &ohci2 {
 	status = "okay";
 };
+
+&pcie_bus_clk {
+	status = "okay";
+};
+
+&pciec0 {
+	status = "okay";
+};
+
+&pciec1 {
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
