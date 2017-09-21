From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 21 Sep 2017 09:17:59 -0500
Subject: [PATCH 2/3] arm64: dts: stratix10: add the 'altr, modrst-off' property
In-Reply-To: <1506003480-22955-1-git-send-email-dinguyen@kernel.org>
References: <1506003480-22955-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1506003480-22955-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Stratix10 reset manager with the 'altr,modrst-offset' property.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index f7fbc38..99e2afe 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -224,6 +224,7 @@
 			#reset-cells = <1>;
 			compatible = "altr,rst-mgr";
 			reg = <0xffd11000 0x1000>;
+			altr,modrst-offset = <0x20>;
 		};
 
 		spi0: spi at ffda4000 {
-- 
2.7.4
