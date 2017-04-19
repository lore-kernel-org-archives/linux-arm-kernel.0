From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Apr 2017 22:30:12 +0200
Subject: [PATCH] ARM: dts: am335x-phycore-som: fix rv4162 compatible
Message-ID: <20170419203012.8158-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rv4162 compatbile string is missing the vendor part, add it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 14533ff6d0ad..428a25e952b0 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -138,7 +138,7 @@
 	};
 
 	i2c_rtc: rtc at 68 {
-		compatible = "rv4162";
+		compatible = "microcrystal,rv4162";
 		reg = <0x68>;
 		status = "disabled";
 	};
-- 
2.11.0
