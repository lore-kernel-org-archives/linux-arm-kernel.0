From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 28 Aug 2013 13:08:27 +0200
Subject: [PATCH 7/9] ARM: at91/dt: add i2c devices connected to at91rm9200ek
 board
In-Reply-To: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1377688107-10830-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index b3e7425..fd2601a 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -147,6 +147,18 @@
 		};
 	};
 
+	i2c at 0 {
+		status = "okay";
+
+		ics1523 at 26 {
+			reg = <0x26>;
+		};
+
+		dac3550 at 4d {
+			reg = <0x4d>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-- 
1.7.9.5
