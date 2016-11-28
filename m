From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 28 Nov 2016 17:31:17 +0300
Subject: [PATCHv2 02/11] ARM: dts: rockchip: update compatible property for
 rk3228 timer
In-Reply-To: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1480343486-25539-3-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property set to '"rockchip,rk3228-timer", "rockchip,rk3288-timer"'
to match devicetree bindings.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 arch/arm/boot/dts/rk3228-evb.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index 904668e..38eab87 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -70,3 +70,7 @@
 &uart2 {
 	status = "okay";
 };
+
+&timer {
+	compatible = "rockchip,rk3228-timer", "rockchip,rk3288-timer";
+};
-- 
1.7.9.5
