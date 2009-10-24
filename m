From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:26:16 +0400
Subject: [PATCH 16/20] SA1100: h3100/h3600: revise copyright boilerplates
In-Reply-To: <1256415813-22892-1-git-send-email-mad_soft@inbox.ru>
References: <1256415813-22892-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415979-22930-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct boilerplates after files split. Also shorten them a bit - use
standart GPL wording (as per http://lkml.org/lkml/2007/5/1/220) and
drop changelog, which only entry about h3800 support and abstracted
EGPIOs is just confusing now, as both of these features are gone.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3100.c              |   23 +++++++----------------
 arch/arm/mach-sa1100/h3600.c              |   23 +++++++----------------
 arch/arm/mach-sa1100/h3xxx.c              |   23 +++++++----------------
 arch/arm/mach-sa1100/include/mach/h3xxx.h |   22 ++++++----------------
 4 files changed, 27 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 4c7778e..303bcd1 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -1,24 +1,15 @@
 /*
- * Hardware definitions for Compaq iPAQ H3xxx Handheld Computers
+ * Support for Compaq iPAQ H3100 handheld computer
  *
- * Copyright 2000,1 Compaq Computer Corporation.
+ * Copyright (c) 2000,1 Compaq Computer Corporation. (Author: Jamey Hicks)
+ * Copyright (c) 2009 Dmitry Artamonow <mad_soft@inbox.ru>
  *
- * Use consistent with the GNU GPL is permitted,
- * provided that this copyright notice is
- * preserved in its entirety in all copies and derived works.
- *
- * COMPAQ COMPUTER CORPORATION MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
- * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
- * FITNESS FOR ANY PARTICULAR PURPOSE.
- *
- * Author: Jamey Hicks.
- *
- * History:
- *
- * 2001-10-??	Andrew Christian   Added support for iPAQ H3800
- *				   and abstracted EGPIO interface.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
  */
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 65ab286..25f189b 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -1,24 +1,15 @@
 /*
- * Hardware definitions for Compaq iPAQ H3xxx Handheld Computers
+ * Support for Compaq iPAQ H3600 handheld computer
  *
- * Copyright 2000,1 Compaq Computer Corporation.
+ * Copyright (c) 2000,1 Compaq Computer Corporation. (Author: Jamey Hicks)
+ * Copyright (c) 2009 Dmitry Artamonow <mad_soft@inbox.ru>
  *
- * Use consistent with the GNU GPL is permitted,
- * provided that this copyright notice is
- * preserved in its entirety in all copies and derived works.
- *
- * COMPAQ COMPUTER CORPORATION MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
- * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
- * FITNESS FOR ANY PARTICULAR PURPOSE.
- *
- * Author: Jamey Hicks.
- *
- * History:
- *
- * 2001-10-??	Andrew Christian   Added support for iPAQ H3800
- *				   and abstracted EGPIO interface.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
  */
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index cf6563c..c9ef056 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -1,24 +1,15 @@
 /*
- * Hardware definitions for Compaq iPAQ H3xxx Handheld Computers
+ * Support for Compaq iPAQ H3100 and H3600 handheld computers (common code)
  *
- * Copyright 2000,1 Compaq Computer Corporation.
+ * Copyright (c) 2000,1 Compaq Computer Corporation. (Author: Jamey Hicks)
+ * Copyright (c) 2009 Dmitry Artamonow <mad_soft@inbox.ru>
  *
- * Use consistent with the GNU GPL is permitted,
- * provided that this copyright notice is
- * preserved in its entirety in all copies and derived works.
- *
- * COMPAQ COMPUTER CORPORATION MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
- * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
- * FITNESS FOR ANY PARTICULAR PURPOSE.
- *
- * Author: Jamey Hicks.
- *
- * History:
- *
- * 2001-10-??	Andrew Christian   Added support for iPAQ H3800
- *				   and abstracted EGPIO interface.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
  */
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-sa1100/include/mach/h3xxx.h b/arch/arm/mach-sa1100/include/mach/h3xxx.h
index d8a6e7c..7d9df16 100644
--- a/arch/arm/mach-sa1100/include/mach/h3xxx.h
+++ b/arch/arm/mach-sa1100/include/mach/h3xxx.h
@@ -1,22 +1,12 @@
 /*
+ * Definitions for Compaq iPAQ H3100 and H3600 handheld computers
  *
- * Definitions for H3600 Handheld Computer
+ * (c) 2000 Compaq Computer Corporation. (Author: Jamey Hicks)
+ * (c) 2009 Dmitry Artamonow <mad_soft@inbox.ru>
  *
- * Copyright 2000 Compaq Computer Corporation.
- *
- * Use consistent with the GNU GPL is permitted,
- * provided that this copyright notice is
- * preserved in its entirety in all copies and derived works.
- *
- * COMPAQ COMPUTER CORPORATION MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
- * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
- * FITNESS FOR ANY PARTICULAR PURPOSE.
- *
- * Author: Jamey Hicks.
- *
- * History:
- *
- * 2001-10-??   Andrew Christian   Added support for iPAQ H3800
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
  */
 
-- 
1.6.5.1.63.ga9d7.dirty
