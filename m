From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Nov 2012 11:45:46 +0900
Subject: [PATCH] Update ARM/SHMOBILE section of MAINTAINERS
Message-ID: <1353984346-25463-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Horman <horms+renesas@verge.net.au>

I have been handling maintenance of shmobile
for a little over a release-cycle now and it seems
to appropriate to update the MAINTAINERS file accordingly.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73060f..056200c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1114,12 +1114,12 @@ S:	Maintained
 F:	drivers/media/platform/s5p-tv/
 
 ARM/SHMOBILE ARM ARCHITECTURE
-M:	Paul Mundt <lethal@linux-sh.org>
+M:	Simon Horman <horms@verge.net.au>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-sh at vger.kernel.org
 W:	http://oss.renesas.com
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-latest
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
-- 
1.7.10.4
