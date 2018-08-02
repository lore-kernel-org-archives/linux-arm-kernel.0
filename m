From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Aug 2018 15:01:33 +0200
Subject: [PATCH 3/3] arm64: dts: rockchip: enable dwc2-based otg controller on
 px30-evb
In-Reply-To: <20180802130133.4898-1-heiko@sntech.de>
References: <20180802130133.4898-1-heiko@sntech.de>
Message-ID: <20180802130133.4898-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the newly added controller on the px30 evaluation board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index c74aa910a631..263d7f3dbc44 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -206,6 +206,10 @@
 	status = "okay";
 };
 
+&usb20_otg {
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.17.0
