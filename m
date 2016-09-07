From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  7 Sep 2016 12:31:23 +0200
Subject: [PATCH 2/8] ARM: dts: bcm283x: Add the emmc pin group to bcm283x.dtsi.
In-Reply-To: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
Message-ID: <1473244289-20728-3-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index acb616f..164d962 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -253,6 +253,10 @@
 				brcm,pins = <32 33>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
 			};
+			emmc_gpio48: emmc_gpio48 {
+				brcm,pins = <48 49 50 51 52 53>;
+				brcm,function = <BCM2835_FSEL_ALT3>;
+			};
 			spi1_gpio16: spi1_gpio16 {
 				brcm,pins = <16 17 18 19 20 21>;
 				brcm,function = <BCM2835_FSEL_ALT4>;
-- 
1.8.3.1
