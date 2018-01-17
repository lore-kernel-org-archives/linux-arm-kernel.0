From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 16:29:50 +0100
Subject: [PATCH 6/6] arm64: zynqmp: Add 8-bit bus width property for ep108
In-Reply-To: <cover.1516202975.git.michal.simek@xilinx.com>
References: <cover.1516202975.git.michal.simek@xilinx.com>
Message-ID: <bbbcb046ab6c2f7b00c5a13f64af43c578e72e5d.1516202975.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>

This patch add 8-bit bus width property to eMMC node.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 22ea2973800c..b089f715c1fb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -97,6 +97,7 @@
 
 &sdhci0 {
 	status = "okay";
+	bus-width = <8>;
 };
 
 &sdhci1 {
-- 
1.9.1
