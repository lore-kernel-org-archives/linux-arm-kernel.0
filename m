From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 18:37:06 +0100
Subject: [PATCHv2 2/8] arm: mvebu: fix vendor prefix typo in
 kirkwood-synology.dtsi
In-Reply-To: <cover.1416158990.git.arno@natisbad.org>
References: <cover.1416158990.git.arno@natisbad.org>
Message-ID: <a7156a5d47c1f9adf7448e3d4999d68a3428c3d6.1416158990.git.arno@natisbad.org>
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
