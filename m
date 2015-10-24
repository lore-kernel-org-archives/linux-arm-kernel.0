From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 24 Oct 2015 12:25:31 +0900
Subject: [PATCH] ARM: dts: uniphier: add I2C aliases for ProXstream2 boards
Message-ID: <1445657131-6351-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add aliases to fix the I2C indexes like the other UniPhier boards.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts | 4 ++++
 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
index 5cb58b6..9d7ec5c 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
@@ -62,6 +62,10 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
+		i2c0 = &i2c0;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts b/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
index 76040bb..498acac 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
@@ -62,6 +62,10 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
+		i2c0 = &i2c0;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
 	};
 };
 
-- 
1.9.1
