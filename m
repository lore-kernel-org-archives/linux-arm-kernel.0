From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 13 Mar 2012 10:12:19 +0530
Subject: [PATCH] MAINTAINERS: Update ST's Mailing list for SPEAr
Message-ID: <ed5b5fcb0dc149e7541d03e1bf13d28fd2bc4ade.1331613701.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have created a ST's Mailing list for SPEAr. This can be accessed from non-st
email ids. I want people to cc this list, when they have changes specific to
SPEAr. So, its better to get this updated in MAINTAINERS file.

Over that, linux-arm-kernel at lists.infradead.org is also added for SPEAr

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 MAINTAINERS |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1fa89b..93d6780 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5884,6 +5884,7 @@ F:	drivers/mmc/host/sdhci-s3c.c
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) ST SPEAR DRIVER
 M:	Viresh Kumar <viresh.kumar@st.com>
+L:	spear-devel at list.st.com
 L:	linux-mmc at vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
@@ -6226,24 +6227,32 @@ F:	drivers/tty/serial/sunzilog.h
 
 SPEAR PLATFORM SUPPORT
 M:	Viresh Kumar <viresh.kumar@st.com>
+L:	spear-devel at list.st.com
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
 S:	Maintained
 F:	arch/arm/plat-spear/
 
 SPEAR3XX MACHINE SUPPORT
 M:	Viresh Kumar <viresh.kumar@st.com>
+L:	spear-devel at list.st.com
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
 S:	Maintained
 F:	arch/arm/mach-spear3xx/
 
 SPEAR6XX MACHINE SUPPORT
 M:	Rajeev Kumar <rajeev-dlh.kumar@st.com>
+L:	spear-devel at list.st.com
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
 S:	Maintained
 F:	arch/arm/mach-spear6xx/
 
 SPEAR CLOCK FRAMEWORK SUPPORT
 M:	Viresh Kumar <viresh.kumar@st.com>
+L:	spear-devel at list.st.com
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
 S:	Maintained
 F:	arch/arm/mach-spear*/clock.c
@@ -6252,6 +6261,8 @@ F:	arch/arm/plat-spear/include/plat/clock.h
 
 SPEAR PAD MULTIPLEXING SUPPORT
 M:	Viresh Kumar <viresh.kumar@st.com>
+L:	spear-devel at list.st.com
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
 S:	Maintained
 F:	arch/arm/plat-spear/include/plat/padmux.h
-- 
1.7.8.110.g4cb5d
