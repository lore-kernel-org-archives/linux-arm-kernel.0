From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 19 Nov 2015 16:06:14 +0000
Subject: [PATCH RFC 2/4] ARM: bcm2835: rename sdhci pin group
In-Reply-To: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1447949176-21926-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node name of the sdhci pin group doesn't explain it's
real function. So rename it.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 3572f03..c5dc57f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -36,7 +36,7 @@
 		brcm,function = <BCM2835_FSEL_ALT0>;
 	};
 
-	alt3: alt3 {
+	sdhci_alt3: sdhci_alt3 {
 		brcm,pins = <48 49 50 51 52 53>;
 		brcm,function = <BCM2835_FSEL_ALT3>;
 	};
-- 
1.7.9.5
