From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:32 +0200
Subject: [PATCH 0108/1529] Fix typo
Message-ID: <20160521115032.4966-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/sdrc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 645a2a4..f115006 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -175,8 +175,8 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
  * don't adjust it down as your clock period increases the refresh interval
  * will not be met. Setting all parameters for complete worst case may work,
  * but may cut memory performance by 2x. Due to errata the DLLs need to be
- * unlocked and their value needs run time calibration.	A dynamic call is
- * need for that as no single right value exists acorss production samples.
+ * unlocked and their value needs run time calibration. A dynamic call is
+ * need for that as no single right value exists across production samples.
  *
  * Only the FULL speed values are given. Current code is such that rate
  * changes must be made at DPLLoutx2. The actual value adjustment for low
-- 
2.8.2.534.g1f66975
