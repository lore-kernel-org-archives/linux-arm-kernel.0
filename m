From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Sun, 23 Nov 2014 11:42:01 +0200
Subject: [PATCH 3/4] ARM: dts: sbc-t3x: add TV out display alias
In-Reply-To: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
References: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1416735722-26167-4-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add display alias for TV out.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-sbc-t3517.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3730.dts |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
index 4ec5d86..1798653 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
@@ -11,6 +11,7 @@
 
 	aliases {
 		display0 = &dvi0;
+		display1 = &tv0;
 	};
 
 	/* Only one GPMC smsc9220 on SBC-T3517, CM-T3517 uses am35x Ethernet */
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
index 8dfc1df..c994f0f 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -11,6 +11,7 @@
 
 	aliases {
 		display0 = &dvi0;
+		display1 = &tv0;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index 6b69864..5bdddf2 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -11,6 +11,7 @@
 
 	aliases {
 		display0 = &dvi0;
+		display1 = &tv0;
 	};
 };
 
-- 
1.7.5.4
