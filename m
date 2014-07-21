From: marek@goldelico.com (Marek Belisko)
Date: Mon, 21 Jul 2014 23:05:26 +0200
Subject: [PATCH 6/7] arm: dts: omap3-gta04: Add display alias
In-Reply-To: <1405976727-15166-1-git-send-email-marek@goldelico.com>
References: <1405976727-15166-1-git-send-email-marek@goldelico.com>
Message-ID: <1405976727-15166-7-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
