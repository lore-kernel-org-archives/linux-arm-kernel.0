From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 10 Feb 2017 15:44:12 +0800
Subject: [PATCH 2/4] arm64: dts: rockchip: add rockchip,
 uphy-dp-sel for Type-C phy
In-Reply-To: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486712654-15431-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip,uphy-dp-sel is the register of type-c phy enable DP function.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8e6d1bd..7e8aa8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1225,6 +1225,7 @@
 		rockchip,usb3tousb2-en = <0xe580 3 19>;
 		rockchip,external-psm = <0xe588 14 30>;
 		rockchip,pipe-status = <0xe5c0 0 0>;
+		rockchip,uphy-dp-sel = <0x6268 19 19>;
 		status = "disabled";
 
 		tcphy0_dp: dp-port {
@@ -1254,6 +1255,7 @@
 		rockchip,usb3tousb2-en = <0xe58c 3 19>;
 		rockchip,external-psm = <0xe594 14 30>;
 		rockchip,pipe-status = <0xe5c0 16 16>;
+		rockchip,uphy-dp-sel = <0x6268 3 19>;
 		status = "disabled";
 
 		tcphy1_dp: dp-port {
-- 
2.6.3
