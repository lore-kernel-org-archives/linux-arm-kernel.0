From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 6 Aug 2014 16:38:52 -0500
Subject: [PATCH] MAINTAINERS: update entries for ARM/SOCFPGA platform
Message-ID: <1407361132-10773-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Update email address, add W and T entries.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f777763..4ea2f6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1343,12 +1343,15 @@ F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
 ARM/SOCFPGA ARCHITECTURE
-M:	Dinh Nguyen <dinguyen@altera.com>
+M:	Dinh Nguyen <dinguyen@opensource.altera.com>
 S:	Maintained
 F:	arch/arm/mach-socfpga/
+W:	http://www.rocketboards.org
+T:	git://git.rocketboards.org/linux-socfpga.git
+T:	git://git.rocketboards.org/linux-socfpga-next.git
 
 ARM/SOCFPGA CLOCK FRAMEWORK SUPPORT
-M:	Dinh Nguyen <dinguyen@altera.com>
+M:	Dinh Nguyen <dinguyen@opensource.altera.com>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
-- 
2.0.3
