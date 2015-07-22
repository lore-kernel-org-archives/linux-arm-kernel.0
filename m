From: eric@anholt.net (Eric Anholt)
Date: Wed, 22 Jul 2015 12:55:36 -0700
Subject: [PATCH 1/2] MAINTAINERS: Add myself as a bcm2835 co-maintainer.
Message-ID: <1437594937-28583-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current maintainers have limited free time to work on the
architecture, and I'm motivated to do so for my work on graphics for
Broadcom.  Arnd and Florian suggested to me that this might be the way
forward.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d55c..1c51379 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2217,6 +2217,7 @@ F:	drivers/clocksource/bcm_kona_timer.c
 BROADCOM BCM2835 ARM ARCHITECTURE
 M:	Stephen Warren <swarren@wwwdotorg.org>
 M:	Lee Jones <lee@kernel.org>
+M:	Eric Anholt <eric@anholt.net>
 L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
-- 
2.1.4
