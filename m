From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  3 Jun 2015 14:24:06 +0200
Subject: [PATCH v2 04/16] ARM: at91/dt: at91rm9200ek: use stdout-path
In-Reply-To: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1433334258-14741-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index 2a5d21247d7e..8dab4b75ca97 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -12,6 +12,10 @@
 	model = "Atmel AT91RM9200 evaluation kit";
 	compatible = "atmel,at91rm9200ek", "atmel,at91rm9200";
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory {
 		reg = <0x20000000 0x4000000>;
 	};
-- 
2.1.4
