From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:19 +0200
Subject: [PATCH 10/32] don't force serial pins to uart0
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-11-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index caf2707..88bcd0c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -38,7 +38,7 @@
 	};
 
 	alt0: alt0 {
-		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 14 15 40 45>;
+		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 40 45>;
 		brcm,function = <BCM2835_FSEL_ALT0>;
 	};
 
-- 
1.8.3.1
