From: rogerq@ti.com (Roger Quadros)
Date: Thu, 19 Sep 2013 16:05:35 +0300
Subject: [RFC PATCH 07/15] ARM: dts: omap5: Update usb3phy node
In-Reply-To: <1379595943-14622-1-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Message-ID: <1379595943-14622-8-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update compatible property for usb3phy node.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 97f361a..06aa665 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -671,7 +671,7 @@
 			};
 
 			usb3_phy: usb3phy at 4a084400 {
-				compatible = "ti,omap-usb3";
+				compatible = "ti,phy-pipe3-usb3";
 				reg = <0x4a084400 0x80>,
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
-- 
1.7.4.1
