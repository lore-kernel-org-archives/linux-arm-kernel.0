From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 11:28:42 +0200
Subject: [PATCH v3 3/4] arm64: dts: rockchip: enable display nodes on
 rk3328-rock64
In-Reply-To: <20180910092843.1700-1-heiko@sntech.de>
References: <20180910092843.1700-1-heiko@sntech.de>
Message-ID: <20180910092843.1700-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable necessary nodes to get output on the hdmi port of the board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index ad82bf39e268..4870c089b6c9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -108,6 +108,14 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmiphy {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -304,3 +312,11 @@
 	dr_mode = "host";
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
-- 
2.17.0
