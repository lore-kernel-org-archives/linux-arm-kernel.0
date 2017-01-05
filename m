From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 5 Jan 2017 15:50:47 +0100
Subject: [PATCH 2/6] ARM: dts: am335x-phycore-som: Update compatible string
 for spi nor
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1483627851-17996-3-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we may have different SPI NOR flashes with 8MB populated on
phyCORE-AM335x SOM, set the "jedec,spi-nor" SPI Flash compatible string.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index ef3fe5a..8060ce5 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -339,7 +339,7 @@
 	status = "okay";
 
 	serial_flash: m25p80 at 0 {
-		compatible = "m25p80";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <48000000>;
 		reg = <0x0>;
 		m25p,fast-read;
-- 
1.9.1
