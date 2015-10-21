From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 21 Oct 2015 20:36:28 +0900
Subject: [PATCH 2/4] ARM: dts: uniphier: delete i2c aliases
In-Reply-To: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1445427390-22750-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The user space should not expect that a particular I2C channel is
always visible through the same character device.
No reason to fix the I2C indexes with aliases.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  | 4 ----
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 7 -------
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts | 6 ------
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts | 5 -----
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts | 4 ----
 5 files changed, 26 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
index f1e9d40..052fcc0 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -65,10 +65,6 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		serial3 = &serial3;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
index 5baa9fc..90563fd 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
@@ -64,13 +64,6 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
-		i2c4 = &i2c4;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
index 2462668..0c52847 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -65,12 +65,6 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		serial3 = &serial3;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
index b7a03215..5b12f5a 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -65,11 +65,6 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
-		i2c4 = &i2c4;
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
index fc7250c..6d788f0 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -65,10 +65,6 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		serial3 = &serial3;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
 	};
 };
 
-- 
1.9.1
