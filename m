From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 2 Apr 2015 23:39:54 -0500
Subject: [PATCH 3/7] ARM: socfpga: dts: enable UART1 for the debug uart
In-Reply-To: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
References: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1428035998-27542-4-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Arria10 devkit is using UART1 for the debug uart port.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dts b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
index 3015ce8..addec61 100755
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
@@ -41,7 +41,7 @@
 			};
 		};
 
-		serial0 at ffc02000 {
+		serial1 at ffc02100 {
 			status = "okay";
 		};
 	};
-- 
2.2.1
