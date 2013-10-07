From: khilman@linaro.org (Kevin Hilman)
Date: Mon,  7 Oct 2013 07:52:33 -0700
Subject: [PATCH] Documentation: arm/Marvell: clarify Armada SoCs that match
 78xx0 pattern
Message-ID: <1381157553-14351-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New users of Marvell SoCs will potentially be confused by the MVEBU
SoCs that match the 78xx0 pattern and thus which defconfig and mach-*
directory to be looking at.  Add a bit of clarification to README for
this.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 Documentation/arm/Marvell/README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 8f08a86..da0151d 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -88,6 +88,7 @@ EBU Armada family
         MV78230
         MV78260
         MV78460
+    NOTE: not to be confused with the non-SMP 78xx0 SoCs
 
   Product Brief: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
   No public datasheet available.
-- 
1.8.3
