From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 15:54:56 +0200
Subject: [PATCH v2 3/4] arm64: dts: rockchip: enable display nodes on
 rk3328-rock64
In-Reply-To: <20180515135457.6252-1-heiko@sntech.de>
References: <20180515135457.6252-1-heiko@sntech.de>
Message-ID: <20180515135457.6252-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable necessary nodes to get output on the hdmi port of the board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5c43a61d3178..ca48be13dee7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -145,6 +145,14 @@
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
 
@@ -341,3 +349,11 @@
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
