From: marek@goldelico.com (Marek Belisko)
Date: Tue, 22 Jul 2014 21:30:19 +0200
Subject: [PATCH v2 6/7] arm: dts: omap3-gta04: Add display alias
In-Reply-To: <1406057420-22269-1-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Message-ID: <1406057420-22269-7-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define alias for lcd display present on gta04 board.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 370c08b..05fd4d2 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -26,6 +26,10 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 
+	aliases {
+		display0 = &lcd;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
1.9.1
