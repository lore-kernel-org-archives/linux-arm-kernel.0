From: marek@goldelico.com (Marek Belisko)
Date: Tue, 22 Jul 2014 21:30:15 +0200
Subject: [PATCH v2 2/7] arm: dts: omap3-gta04: Fix magnetometer model
In-Reply-To: <1406057420-22269-1-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Message-ID: <1406057420-22269-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gta04 is using hmc5843l not hmc5843 so fix wrong compatible
entry.

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
