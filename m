From: eric@anholt.net (Eric Anholt)
Date: Wed, 22 Jul 2015 12:55:37 -0700
Subject: [PATCH 2/2] MAINTAINERS: Explicitly add linux-arm-kernel for bcm2835
In-Reply-To: <1437594937-28583-1-git-send-email-eric@anholt.net>
References: <1437594937-28583-1-git-send-email-eric@anholt.net>
Message-ID: <1437594937-28583-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_maintainers.pl would list linux-arm-kernel for most bcm2835
changes because it's under arch/arm, but might not for other bcm2835
drivers.  Most ARM architectures appear to list linux-arm-kernel as an
appropriate list as well.

Signed-off-by: Eric Anholt <eric@anholt.net>
Suggested-by: Stephen Warren <swarren@wwwdotorg.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c51379..226beaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2219,6 +2219,7 @@ M:	Stephen Warren <swarren@wwwdotorg.org>
 M:	Lee Jones <lee@kernel.org>
 M:	Eric Anholt <eric@anholt.net>
 L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
 N:	bcm2835
-- 
2.1.4
