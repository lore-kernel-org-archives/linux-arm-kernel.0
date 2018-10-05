From: james.morse@arm.com (James Morse)
Date: Fri,  5 Oct 2018 15:21:20 +0100
Subject: [PATCH] MAINTAINERS: fix bad sdei paths
Message-ID: <20181005142120.13279-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDEI header files had an 'arm_' namespace added, but the patterns
in the MAINTAINERS files were missed. Oops.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
The SDEI stuff originally went via arm64, ... what about this?

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c7069037a15..30df8d42baa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13186,8 +13186,8 @@ L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/firmware/sdei.txt
 F:	drivers/firmware/arm_sdei.c
-F:	include/linux/sdei.h
-F:	include/uapi/linux/sdei.h
+F:	include/linux/arm_sdei.h
+F:	include/uapi/linux/arm_sdei.h
 
 SOFTWARE RAID (Multiple Disks) SUPPORT
 M:	Shaohua Li <shli@kernel.org>
-- 
2.17.1
