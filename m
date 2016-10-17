From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 12:44:06 -0700
Subject: [PATCH 5/5] MAINTAINERS: Add the staging vchiq driver as a bcm2835
 responsibility.
In-Reply-To: <20161017194406.1080-1-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
Message-ID: <20161017194406.1080-6-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's being merged to support firmware communication on the Raspberry
Pi, so we should probably send its patches to linux-rpi-kernel.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

Greg, I'd be pulling this one through broadcom trees.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7e0064..8ed85a51d9c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2586,6 +2586,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
 N:	bcm2835
+F:	drivers/staging/vc04_services
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
-- 
2.9.3
