From: rajeevkumar.linux@gmail.com (Rajeev Kumar)
Date: Tue, 28 Apr 2015 11:08:19 +0530
Subject: [PATCH V2] Update email-id of author
Message-ID: <1430199499-16278-1-git-send-email-rajeevkumar.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rajeev-dlh.kumar at st.com email-id doesn't exist anymore as I have left the
company.  Replace ST's id with Rajeev Kumar <rajeevkumar.linux@gmail.com>

It also updates .mailmap file to fix address for 'git shortlog'

Signed-off-by: Rajeev Kumar <rajeevkumar.linux@gmail.com>
---
 .mailmap                                 |    1 +
 arch/arm/mach-spear/generic.h            |    2 +-
 arch/arm/mach-spear/include/mach/irqs.h  |    2 +-
 arch/arm/mach-spear/include/mach/spear.h |    2 +-
 arch/arm/mach-spear/spear6xx.c           |    2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0d971cf..6e5cb4c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -96,6 +96,7 @@ Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
 Praveen BP <praveenbp@ti.com>
+Rajeev Kumar <rajeevkumar.linux@gmail.com> <rajeev-dlh.kumar@st.com>
 Rajesh Shah <rajesh.shah@intel.com>
 Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index a99d90a..0bfd2ea 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -2,7 +2,7 @@
  * spear machine family generic header file
  *
  * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-spear/include/mach/irqs.h b/arch/arm/mach-spear/include/mach/irqs.h
index 92da0a8..022cf98 100644
--- a/arch/arm/mach-spear/include/mach/irqs.h
+++ b/arch/arm/mach-spear/include/mach/irqs.h
@@ -2,7 +2,7 @@
  * IRQ helper macros for spear machine family
  *
  * Copyright (C) 2009-2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index f2d6a01..0d2f14d 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -2,7 +2,7 @@
  * SPEAr3xx/6xx Machine family specific definition
  *
  * Copyright (C) 2009,2012 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  * Viresh Kumar <viresh.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index da26fa5b..c6dcb0d 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -4,7 +4,7 @@
  * SPEAr6XX machines common source file
  *
  * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  *
  * Copyright 2012 Stefan Roese <sr@denx.de>
  *
-- 
1.7.9.5
