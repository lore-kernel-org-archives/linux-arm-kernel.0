From: david.wu@rock-chips.com (David Wu)
Date: Tue, 25 Jul 2017 18:08:01 +0800
Subject: [PATCH] arm64: dts: rockchip: Add rk3328 io-domain node
Message-ID: <1500977281-3404-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 7e69f1f..cf34529 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -162,6 +162,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rk3328-io-voltage-domain";
+			status = "disabled";
+		};
+
 		power: power-controller {
 			compatible = "rockchip,rk3328-power-controller";
 			#power-domain-cells = <1>;
-- 
1.9.1
