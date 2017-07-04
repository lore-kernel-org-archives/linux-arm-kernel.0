From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  4 Jul 2017 17:31:17 +0800
Subject: [PATCH] ARM: dts: zte: remove num-slots from zx296702-ad1
Message-ID: <1499160677-78463-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwmmc driver deprecated num-slots and plan to get rid
of it finally. Just move a step to cleanup it from DT.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm/boot/dts/zx296702-ad1.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
index 081f980..b0183c3 100644
--- a/arch/arm/boot/dts/zx296702-ad1.dts
+++ b/arch/arm/boot/dts/zx296702-ad1.dts
@@ -18,7 +18,6 @@
 };
 
 &mmc0 {
-	num-slots = <1>;
 	supports-highspeed;
 	non-removable;
 	disable-wp;
@@ -31,7 +30,6 @@
 };
 
 &mmc1 {
-	num-slots = <1>;
 	supports-highspeed;
 	non-removable;
 	disable-wp;
-- 
1.9.1
