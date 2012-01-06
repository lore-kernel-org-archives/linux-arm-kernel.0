From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  6 Jan 2012 16:33:52 +0100
Subject: [PATCH RFC] ARM: at91: removal of CAP9 SoC family
Message-ID: <1325864033-20012-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atmel CAP9 family is not maintained well and products may be
difficult to find now. It will allow to save workforce and
remove LOC during current cleanup process.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/feature-removal-schedule.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 3d84912..23dfea5 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -551,3 +551,17 @@ When:	3.5
 Why:	The iwlagn module has been renamed iwlwifi.  The alias will be around
 	for backward compatibility for several cycles and then dropped.
 Who:	Don Fry <donald.h.fry@intel.com>
+
+----------------------------
+
+What:	The CAP9 SoC family will be removed
+When:	3.4
+Files:	arch/arm/mach-at91/at91cap9.c
+	arch/arm/mach-at91/at91cap9_devices.c
+	arch/arm/mach-at91/include/mach/at91cap9.h
+	arch/arm/mach-at91/include/mach/at91cap9_matrix.h
+	arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
+	arch/arm/mach-at91/board-cap9adk.c
+Why:	The code is not actively maintained and platforms are now hard to find.
+Who:	Nicolas Ferre <nicolas.ferre@atmel.com>
+	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
-- 
1.7.5.4
