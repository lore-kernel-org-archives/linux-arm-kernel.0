From: radek.dostal@streamunlimited.com (Radek Dostal)
Date: Mon, 10 Nov 2014 17:35:58 +0100
Subject: [PATCH] ARM: dts: bcm63138: change "interupts" to "interrupts"
Message-ID: <1415637358-24378-1-git-send-email-radek.dostal@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

all other nodes in bcm63138.dtsi use "interrupts", this had to be just a typo
which never got noticed, even it may have quite some consequences.

Signed-off-by: Radek Dostal <radek.dostal@streamunlimited.com>
---
 Hi all,

 when running git grep with typo, I spotted this typo inDT binding, which 
 looks obviously wrong to me. Sorry I do not have the board to test it, but 
 I am pretty sure the patch is correct.

 I hope I included, right people get_maintainer.pl showed bit too many.

 Thanks,
 Radek

 arch/arm/boot/dts/bcm63138.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index f3bb2dd..d2d8e94 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -102,7 +102,7 @@
 		twd_watchdog: watchdog at 1e620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0x1e620 0x20>;
-			interupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 
-- 
1.7.9.5
