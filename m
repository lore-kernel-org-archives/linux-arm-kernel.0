From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 14 Apr 2016 08:20:37 -0400
Subject: [PATCH 3/3] arm: dts: phy3250: enable ssp0
In-Reply-To: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1460636437-21764-4-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/boot/dts/phy3250.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index a00d7ce..26e070f 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -146,6 +146,7 @@
 				#size-cells = <0>;
 				num-cs = <1>;
 				cs-gpios = <&gpio 3 5 0>;
+				status = "okay";
 
 				eeprom: at25 at 0 {
 					pl022,interface = <0>;
-- 
1.8.3.1
