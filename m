From: john@metanate.com (John Keeping)
Date: Sun, 18 Feb 2018 17:03:36 +0000
Subject: [PATCH 3/3] ARM: dts: rockchip: enable USB-OTG port on Radxa Rock2
 Square
In-Reply-To: <20180218170336.31819-1-john@metanate.com>
References: <20180218170336.31819-1-john@metanate.com>
Message-ID: <20180218170336.31819-3-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the USB gadget framework to be used on Rock2 Square.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288-rock2-square.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 0ea2a3a1fa51..8ccc89dbdfaf 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -321,3 +321,7 @@
 &usb_host1 {
 	status = "okay";
 };
+
+&usb_otg {
+	status = "okay";
+};
-- 
2.16.1
