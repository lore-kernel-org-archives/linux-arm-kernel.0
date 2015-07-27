From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 27 Jul 2015 11:48:14 +0200
Subject: [PATCH 6/7] ARM64: zynqmp: Enable sdhci on ep108
In-Reply-To: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
References: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
Message-ID: <f6be42a011f11a399e04939f726bcefb202eba49.1437990464.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable both sdhcis on ep108.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index faee1617ab16..206e18eca2fb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -55,6 +55,14 @@
 	ceva,broken-gen2;
 };
 
+&sdhci0 {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.3.5
