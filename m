From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 29 Aug 2014 10:22:21 +0800
Subject: [PATCH] ARM: dts: vf610-twr: remove useless property for sound card.
Message-ID: <1409278941-16975-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was added by:
Commit 8128c4f36 ("ARM: dts: vf610-twr: Add simple-card support.")

This useless property may cause some confusions for users.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 58e988e..82d16ac 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -76,7 +76,6 @@
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai2>;
-			master-clkdir-out;
 			frame-master;
 			bitclock-master;
 		};
-- 
1.8.5
