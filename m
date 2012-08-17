From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 17 Aug 2012 16:23:56 +0800
Subject: [PATCH] arm: dts: remove partial parameter in at91sam9g25ek.dts
Message-ID: <1345191836-16523-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the partial parameter in at91sam9g25ek.dts file

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 7829a4d..96514c1 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -15,7 +15,7 @@
 	compatible = "atmel,at91sam9g25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "128M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
+		bootargs = "console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
 	};
 
 	ahb {
-- 
1.7.10
