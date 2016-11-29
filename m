From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 29 Nov 2016 16:45:08 +0300
Subject: [PATCH v3 03/13] ARM: dts: rockchip: update compatible property for
 rk3229 timer
In-Reply-To: <1480427118-5126-1-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480427118-5126-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1480427118-5126-4-git-send-email-al.kochet@gmail.com>
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
