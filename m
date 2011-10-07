From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  7 Oct 2011 23:06:21 +0800
Subject: [PATCH] MAINTAINERS: add ARM/FREESCALE IMX6 entry
In-Reply-To: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
References: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317999981-2802-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds maintainer for ARM/FREESCALE IMX6.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65ca7ea..05e4d69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -786,6 +786,13 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-mx5/
 
+ARM/FREESCALE IMX6
+M:	Shawn Guo <shawn.guo@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git git://git.linaro.org/people/shawnguo/linux-2.6.git
+F:	arch/arm/mach-imx/*imx6*
+
 ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.4.1
