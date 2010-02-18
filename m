From: bzolnier@gmail.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 18 Feb 2010 15:47:40 +0100
Subject: [PATCH] Documentation: remove obsolete arm/Sharp-LH/LPD7A400 file
Message-ID: <201002181547.41043.bzolnier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


It has been obsoleted by Documentation/arm/Sharp-LH/LPD7A40X
and can be safely removed.

Inspired-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/arm/Sharp-LH/LPD7A400 |   15 ---------------
 1 file changed, 15 deletions(-)

Index: b/Documentation/arm/Sharp-LH/LPD7A400
===================================================================
--- a/Documentation/arm/Sharp-LH/LPD7A400
+++ /dev/null
@@ -1,15 +0,0 @@
-README on Implementing Linux for the Logic PD LPD7A400-10
-=========================================================
-
-- CPLD memory mapping
-
-  The board designers chose to use high address lines for controlling
-  access to the CPLD registers.  It turns out to be a big waste
-  because we're using an MMU and must map IO space into virtual
-  memory.  The result is that we have to make a mapping for every
-  register.
-
-- Serial Console
-
-  It may be OK not to use the serial console option if the user passes
-  the console device name to the kernel.  This deserves some exploration.
