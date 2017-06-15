From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 15 Jun 2017 15:21:47 +0800
Subject: [PATCH 5/6] ARM: dts: rockchip: Add io-domain node for rk3228
In-Reply-To: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1497511307-23262-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <david.wu@rock-chips.com>

This patch adds io-domain support for rk3228 SoC.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 5e7b54c..c2a78f4 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -215,6 +215,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rk3228-io-voltage-domain";
+			status = "disabled";
+		};
+
 		u2phy0: usb2-phy at 760 {
 			compatible = "rockchip,rk3228-usb2phy";
 			reg = <0x0760 0x0c>;
-- 
2.0.0
