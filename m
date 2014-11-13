From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 10:39:00 +0100
Subject: [PATCHv3 5/5] ARM: mvebu: update comments in coherency.c
In-Reply-To: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1415871540-20302-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coherency.c top-level comment mentions that it supports the
coherency fabric for Armada 370 and XP, but it also supports the
coherency fabric on Armada 375 and 38x, so this commit updates the
comment accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index e568b2e..c18da36 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -1,5 +1,6 @@
 /*
- * Coherency fabric (Aurora) support for Armada 370 and XP platforms.
+ * Coherency fabric (Aurora) support for Armada 370, 375, 38x and XP
+ * platforms.
  *
  * Copyright (C) 2012 Marvell
  *
@@ -11,7 +12,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  *
- * The Armada 370 and Armada XP SOCs have a coherency fabric which is
+ * The Armada 370, 375, 38x and XP SOCs have a coherency fabric which is
  * responsible for ensuring hardware coherency between all CPUs and between
  * CPUs and I/O masters. This file initializes the coherency fabric and
  * supplies basic routines for configuring and controlling hardware coherency
-- 
2.0.0
