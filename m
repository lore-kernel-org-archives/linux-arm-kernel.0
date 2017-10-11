From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 11 Oct 2017 03:29:11 -0500
Subject: [PATCH] arm64: dts: stratix10: fix interrupt number for gpio1
Message-ID: <1507710551-28323-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio1 node's interrupt number should be 111.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 721b91a..7c9bdc7 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -165,7 +165,7 @@
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <0 110 4>;
+				interrupts = <0 111 4>;
 			};
 		};
 
-- 
2.7.4
