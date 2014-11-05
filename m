From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  4 Nov 2014 20:27:17 -0700
Subject: [PATCH] MAINTAINERS: update bcm2835 entry
Message-ID: <1415158037-12015-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Lee Jones as a new co-maintainer.

The kernel.org repo moved to allow us both to push to it. Update
MAINTAINERS to match.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c41896bbf1f..203f6a2fe0d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2065,8 +2065,9 @@ F:	drivers/clocksource/bcm_kona_timer.c
 
 BROADCOM BCM2835 ARM ARCHITECTURE
 M:	Stephen Warren <swarren@wwwdotorg.org>
+M:	Lee Jones <lee@kernel.org>
 L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
 N:	bcm2835
 
-- 
1.9.1
