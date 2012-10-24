From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Oct 2012 11:00:29 -0700
Subject: [PATCH] MAINTAINERS: Add arm-soc tree entry
Message-ID: <1351101629-11826-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the arm-soc tree in the maintainers file so that
developers know how arm SoC development is structured.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 014272b..f70afea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -637,6 +637,13 @@ W:	http://www.arm.linux.org.uk/
 S:	Maintained
 F:	arch/arm/
 
+ARM SUB-ARCHITECTURES
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	MAINTAINED
+F:	arch/arm/mach-*/
+F:	arch/arm/plat-*/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
+
 ARM PRIMECELL AACI PL041 DRIVER
 M:	Russell King <linux@arm.linux.org.uk>
 S:	Maintained
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
