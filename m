From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Aug 2015 23:45:13 +0200
Subject: [PATCH 3/3] ARM: dts: rockchip: enable usb controller on marsboard
In-Reply-To: <1617149.AMXNNUATDo@diego>
References: <1617149.AMXNNUATDo@diego>
Message-ID: <5410702.spv0GayXVB@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the previously disabled usb controllers on the marsboard
and makes it possible to for example mount usb mass storage devices.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-marsboard.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index 08f5b43..bae965c 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -206,6 +206,14 @@
 	status = "okay";
 };
 
+&usb_host {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.1.4
