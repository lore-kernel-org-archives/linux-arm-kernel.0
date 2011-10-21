From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Oct 2011 11:53:34 +0800
Subject: [PATCH] MAINTAINERS: add ARM/FREESCALE MXS entry
Message-ID: <1319169214-8002-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Pengutronix, they want to get Sascha relieved from
the burden of maintaining MXS sub-architecture.  Since I brought the
most of MXS core code to mainline (with the great help from
Pengutronix people, thanks!), I would like to step up for maintaining
MXS.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Hi Sascha,

Please help finish up MXS maintainership for the coming merge window,
and I can start taking it over after the merge window closes.  Thanks.

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5483e0c..7bb20d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -787,6 +787,13 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-mx5/
 
+ARM/FREESCALE MXS ARM ARCHITECTURE
+M:	Shawn Guo <shawn.guo@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git git://git.linaro.org/people/shawnguo/linux-2.6.git
+F:	arch/arm/mach-mxs/
+
 ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.4.1
