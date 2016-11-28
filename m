From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 28 Nov 2016 17:31:18 +0300
Subject: [PATCHv2 03/11] ARM: dts: rockchip: update compatible property for
 rk3229 timer
In-Reply-To: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1480343486-25539-4-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property set to '"rockchip,rk3229-timer", "rockchip,rk3288-timer"'
to match devicetree bindings.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 arch/arm/boot/dts/rk3229-evb.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index b6a1203..6629769 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -88,3 +88,7 @@
 &uart2 {
 	status = "okay";
 };
+
+&timer {
+	compatible = "rockchip,rk3229-timer", "rockchip,rk3288-timer";
+};
-- 
1.7.9.5
