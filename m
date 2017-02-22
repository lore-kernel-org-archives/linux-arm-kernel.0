From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 21 Feb 2017 19:43:21 -0700
Subject: [PATCH] MAINTAINERS: remove swarren from bcm2835
Message-ID: <1487731401-4362-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I haven't been active in BCM2835 maintenance for quite a while; Eric's
been doing a great job. As such, remove myself from MAINTAINERS for that.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 277c2e2062bd..87bbd3744238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2648,7 +2648,6 @@ N:	kona
 F:	arch/arm/mach-bcm/
 
 BROADCOM BCM2835 ARM ARCHITECTURE
-M:	Stephen Warren <swarren@wwwdotorg.org>
 M:	Lee Jones <lee@kernel.org>
 M:	Eric Anholt <eric@anholt.net>
 L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.7.4
