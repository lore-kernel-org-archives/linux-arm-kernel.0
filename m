From: andrealmeid@riseup.net (andrealmeid at riseup.net)
Date: Tue,  6 Nov 2018 22:07:38 -0200
Subject: [PATCH] Staging: vchi: Add license id and change int type
Message-ID: <20181107000738.26963-1-andrealmeid@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andr? Almeida <andrealmeid@riseup.net>

Fix the following checkpatch issues:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
CHECK: Prefer kernel type 's32' over 'int32_t'

Signed-off-by: Andr? Almeida <andrealmeid@riseup.net>

---

Hello! This is my first patch to Linux Kernel. Let me know any feedback
---
 drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
index 198bd076b666..42fc0c693d43 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
@@ -1,5 +1,5 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
@@ -36,7 +36,7 @@
 
 #include <linux/types.h>
 
-typedef int32_t VCHI_MEM_HANDLE_T;
+typedef s32 VCHI_MEM_HANDLE_T;
 #define VCHI_MEM_HANDLE_INVALID 0
 
 #endif
-- 
2.19.1
