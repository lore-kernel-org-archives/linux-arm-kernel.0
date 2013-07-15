From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:54 +0200
Subject: [PATCH 09/22] arm/dts: imx25.dtsi: Add an alias for the Audio
 Multiplexer.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-10-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index f7f024f..b0b2fea 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -235,7 +235,7 @@
 				};
 			};
 
-			audmux at 43fb0000 {
+			audmux: audmux at 43fb0000 {
 				compatible = "fsl,imx25-audmux", "fsl,imx31-audmux";
 				reg = <0x43fb0000 0x4000>;
 				status = "disabled";
-- 
1.7.9.5
