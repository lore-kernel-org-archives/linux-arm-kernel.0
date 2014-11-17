From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 00:27:07 +0100
Subject: [PATCHv3 02/12] arm: mvebu: fix vendor prefix typo in
 kirkwood-synology.dtsi
In-Reply-To: <cover.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
Message-ID: <bac0c46a9ca8d88dbf8a67108084acc3736f31b4.1416266432.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


As reported by Andrew, the vendor prefix for Seiko Instruments, Inc.
S-35390A I2C RTC chip in kirkwood-synology.dtsi has a typo (ssi
instead of sii). This patches fixes it.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/kirkwood-synology.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
index 811e0971fc58..8be5b2e4626e 100644
--- a/arch/arm/boot/dts/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -266,7 +266,7 @@
 
 			s35390a: s35390a at 30 {
 				status = "disabled";
-				compatible = "ssi,s35390a";
+				compatible = "sii,s35390a";
 				reg = <0x30>;
 			};
 		};
-- 
2.1.1
