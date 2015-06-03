From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  3 Jun 2015 14:24:05 +0200
Subject: [PATCH v2 03/16] ARM: at91/dt: kizbox: use stdout-path
In-Reply-To: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1433334258-14741-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1433334258-14741-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kizbox dts are using the deprecated linux,stdout-path. Replace those by
stdout-path.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/at91-kizbox.dts     | 2 +-
 arch/arm/boot/dts/at91-kizbox2.dts    | 2 +-
 arch/arm/boot/dts/at91-kizboxmini.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index b567b5ff908f..d9b71065916d 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -16,7 +16,7 @@
 
 	chosen {
 		bootargs = "ubi.mtd=ubi";
-		linux,stdout-path = &dbgu;
+		stdout-path = &dbgu;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/at91-kizbox2.dts b/arch/arm/boot/dts/at91-kizbox2.dts
index a458e3791bb1..f0b1563cb3f1 100644
--- a/arch/arm/boot/dts/at91-kizbox2.dts
+++ b/arch/arm/boot/dts/at91-kizbox2.dts
@@ -15,7 +15,7 @@
 
 	chosen {
 		bootargs = "ubi.mtd=ubi";
-		linux,stdout-path = &dbgu;
+		stdout-path = &dbgu;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/at91-kizboxmini.dts b/arch/arm/boot/dts/at91-kizboxmini.dts
index 4611f227d8d0..9f72b4932634 100644
--- a/arch/arm/boot/dts/at91-kizboxmini.dts
+++ b/arch/arm/boot/dts/at91-kizboxmini.dts
@@ -15,7 +15,7 @@
 
 	chosen {
 		bootargs = "ubi.mtd=ubi";
-		linux,stdout-path = &dbgu;
+		stdout-path = &dbgu;
 	};
 
 	memory {
-- 
2.1.4
