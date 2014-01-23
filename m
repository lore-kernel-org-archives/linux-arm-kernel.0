From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:16 +0100
Subject: [PATCH v3 12/15] at91: dt: sam9261: adds description for the bus
 matrix
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-13-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 79d7554..112e587 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -220,6 +220,11 @@
 				reg = <0xffffea00 0x200>;
 			};
 
+			matrix: matrix at ffffee00 {
+				compatible = "atmel,at91sam9261-bus-matrix";
+				reg = <0xffffee00 0x200>;
+			};
+
 			aic: interrupt-controller at fffff000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,at91rm9200-aic";
-- 
1.8.5.2
