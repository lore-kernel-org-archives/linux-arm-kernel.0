From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Jun 2012 09:39:29 +0200
Subject: [PATCHv2] ARM: dts: cfa10036: Add Power LED to the CFA-10036 board
Message-ID: <1340955569-16513-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Brian Lilly <brian@crystalfontz.com>
---
 arch/arm/boot/dts/cfa10036.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/cfa10036.dts b/arch/arm/boot/dts/cfa10036.dts
index 28b9326..c03a577 100644
--- a/arch/arm/boot/dts/cfa10036.dts
+++ b/arch/arm/boot/dts/cfa10036.dts
@@ -40,4 +40,13 @@
 			};
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power {
+			gpios = <&gpio3 4 1>;
+			default-state = "on";
+		};
+	};
 };
-- 
1.7.9.5
