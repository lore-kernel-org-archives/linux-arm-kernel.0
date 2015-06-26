From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 26 Jun 2015 09:04:32 -0700
Subject: [PATCH RFC] MAINTAINERS: Update Zynq git tree location
Message-ID: <1435334672-8825-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The git tree for Zynq moved to Github. Update the MAINTAINERS record to
reflect the change.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a01df3088b01..f6b16941ae08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,7 +1639,7 @@ M:	Michal Simek <michal.simek@xilinx.com>
 R:	S?ren Brinkmann <soren.brinkmann@xilinx.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://wiki.xilinx.com
-T:	git git://git.xilinx.com/linux-xlnx.git
+T:	git https://github.com/Xilinx/linux-xlnx.git
 S:	Supported
 F:	arch/arm/mach-zynq/
 F:	drivers/cpuidle/cpuidle-zynq.c
-- 
2.4.4.3.gd756881
