From: eagle.alexander923@gmail.com (Alexander Shiyan)
Date: Sun, 23 Jun 2013 10:54:48 +0400
Subject: [PATCH 4/6] ARM: dts: imx27: Sort entries by address
In-Reply-To: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
References: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
Message-ID: <1371970490-10874-4-git-send-email-eagle.alexander923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 845af3f..85890d8 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -382,11 +382,6 @@
 			};
 		};
 
-		iram: iram at ffff4c00 {
-			compatible = "mmio-sram";
-			reg = <0xffff4c00 0xb400>;
-		};
-
 		nfc: nand at d8000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -396,5 +391,10 @@
 			clocks = <&clks 54>;
 			status = "disabled";
 		};
+
+		iram: iram at ffff4c00 {
+			compatible = "mmio-sram";
+			reg = <0xffff4c00 0xb400>;
+		};
 	};
 };
-- 
1.8.1.5
