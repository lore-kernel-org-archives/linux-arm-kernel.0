From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Jul 2018 13:22:16 +0100
Subject: [PATCH] MAINTAINERS: arm64: Remove boot/dts/ directory from arm64
 entry
Message-ID: <1530879736-7650-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm-soc tree does a good job handling .dts files, so exclude them
from the ARM64 entry in MAINTAINERS.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576fc766..61301440e66f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2264,6 +2264,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 S:	Maintained
 F:	arch/arm64/
+X:	arch/arm64/boot/dts/
 F:	Documentation/arm64/
 
 AS3645A LED FLASH CONTROLLER DRIVER
-- 
2.1.4
