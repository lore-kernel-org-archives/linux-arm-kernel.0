From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:18:33 +0900
Subject: [PATCH 6/9] ARM: dts: uniphier: enable I2C channel 2 of ProXstream2
 Gentil board
In-Reply-To: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456471116-8140-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used for on-board inter-connection.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
index 0da3018..bf2619e 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
@@ -63,6 +63,7 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		i2c0 = &i2c0;
+		i2c2 = &i2c2;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 		i2c6 = &i2c6;
@@ -81,3 +82,7 @@
 		reg = <0x54>;
 	};
 };
+
+&i2c2 {
+	status = "okay";
+};
-- 
1.9.1
