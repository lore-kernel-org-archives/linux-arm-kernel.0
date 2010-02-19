From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Feb 2010 09:52:11 +0100
Subject: [PATCH] ARM: fix documentation of the PrimeCell bus
Message-ID: <1266569531-31618-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus@foobar.localdomain>

This fixes the filepath encoded in <linux/amba/bus.h> and adds
some documentation as to what this bus really means.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 include/linux/amba/bus.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index ab94335..6816be6 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -1,5 +1,9 @@
 /*
- *  linux/include/asm-arm/hardware/amba.h
+ *  linux/include/amba/bus.h
+ *
+ *  This device type deals with ARM PrimeCells and anything else that
+ *  presents a proper CID (0xB105F00D) at the end of the I/O register
+ *  region or that is derived from a PrimeCell.
  *
  *  Copyright (C) 2003 Deep Blue Solutions Ltd, All Rights Reserved.
  *
-- 
1.6.6
