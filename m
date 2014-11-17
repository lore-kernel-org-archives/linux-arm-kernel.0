From: radek.dostal@streamunlimited.com (Radek Dostal)
Date: Mon, 17 Nov 2014 15:41:18 +0100
Subject: [PATCH RESEND] ARM: dts: bcm63138: change "interupts" to "interrupts"
In-Reply-To: <5460F9EF.5010605@gmail.com>
References: <5460F9EF.5010605@gmail.com>
Message-ID: <1416235278-15759-1-git-send-email-radek.dostal@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

all other nodes in bcm63138.dtsi use "interrupts", this had to be just a typo
which never got noticed, even it may have quite some consequences.

Signed-off-by: Radek Dostal <radek.dostal@streamunlimited.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Dear all,

 resending the previous patch with added Acked-by from Florian Fainelli. I
 did not hear anything back for almost a week. Additionally CC to
 trivial at kernel.org as it may qualify for it.

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
