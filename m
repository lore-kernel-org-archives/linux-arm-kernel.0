From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Apr 2015 14:13:12 -0500
Subject: [PATCH] MAINTAINERS: socfpga: update the git repo for SoCFPGA
Message-ID: <1429557192-23866-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The git tree at rocketboards.org is going away. Update the entry to reflect
the address of the new location. Also add an entry for all the socfpga_*
dts files.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index db335f9..b939fc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1447,9 +1447,10 @@ ARM/SOCFPGA ARCHITECTURE
 M:	Dinh Nguyen <dinguyen@opensource.altera.com>
 S:	Maintained
 F:	arch/arm/mach-socfpga/
+F:	arch/arm/boot/dts/socfpga*
+F:	arch/arm/configs/socfpga_defconfig
 W:	http://www.rocketboards.org
-T:	git://git.rocketboards.org/linux-socfpga.git
-T:	git://git.rocketboards.org/linux-socfpga-next.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
 
 ARM/SOCFPGA CLOCK FRAMEWORK SUPPORT
 M:	Dinh Nguyen <dinguyen@opensource.altera.com>
-- 
2.2.1
