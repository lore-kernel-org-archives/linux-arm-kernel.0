From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  9 Dec 2017 01:07:38 +0100
Subject: [PATCH 3/3] arm64: dts: rockchip: enable gpu on rk3328-rock64
In-Reply-To: <20171209000738.32187-1-heiko@sntech.de>
References: <20171209000738.32187-1-heiko@sntech.de>
Message-ID: <20171209000738.32187-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Mali450MP2 on the Rock64 board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index d4f80786e7c2..4351fdd1f101 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -144,6 +144,10 @@
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
-- 
2.14.2
