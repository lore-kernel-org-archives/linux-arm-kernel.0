From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Apr 2016 14:00:34 +0530
Subject: [PATCH] MAINTAINERS: fix stale TI DaVinci entries
Message-ID: <1460709034-13189-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix stale git tree entry. Patchwork project has
not been updated since TI DaVinci lost its
dedicated mailing list. Remove that entry.

Update mailing list to point to LAKML.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7c88eb..c0155f40909a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10148,8 +10148,8 @@ F:	arch/arm/mach-s3c24xx/bast-irq.c
 TI DAVINCI MACHINE SUPPORT
 M:	Sekhar Nori <nsekhar@ti.com>
 M:	Kevin Hilman <khilman@kernel.org>
-T:	git git://gitorious.org/linux-davinci/linux-davinci.git
-Q:	http://patchwork.kernel.org/project/linux-davinci/list/
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
 S:	Supported
 F:	arch/arm/mach-davinci/
 F:	drivers/i2c/busses/i2c-davinci.c
-- 
2.6.3
