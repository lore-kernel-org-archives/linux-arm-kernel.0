From: marek@goldelico.com (Marek Belisko)
Date: Mon, 21 Jul 2014 23:05:22 +0200
Subject: [PATCH 2/7] arm: dts: omap3-gta04: Fix magnetometer model
In-Reply-To: <1405976727-15166-1-git-send-email-marek@goldelico.com>
References: <1405976727-15166-1-git-send-email-marek@goldelico.com>
Message-ID: <1405976727-15166-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 7d7ddd7..6d1a8d8 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -220,7 +220,7 @@
 
 	/* compass aka magnetometer */
 	hmc5843 at 1e {
-		compatible = "honeywell,hmc5843";
+		compatible = "honeywell,hmc5843l";
 		reg = <0x1e>;
 	};
 
-- 
1.9.1
