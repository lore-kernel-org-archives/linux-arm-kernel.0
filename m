From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  9 Jan 2018 18:57:36 +0100
Subject: [PATCH 2/2] crypto: s5p-sss - Add SPDX license identifier
In-Reply-To: <20180109175736.6885-1-krzk@kernel.org>
References: <20180109175736.6885-1-krzk@kernel.org>
Message-ID: <20180109175736.6885-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL license statement with SPDX GPL-2.0 license identifier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/s5p-sss.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 62830a43d959..188f44b7eb27 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1,17 +1,13 @@
-/*
- * Cryptographic API.
- *
- * Support for Samsung S5PV210 and Exynos HW acceleration.
- *
- * Copyright (C) 2011 NetUP Inc. All rights reserved.
- * Copyright (c) 2017 Samsung Electronics Co., Ltd. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- *
- * Hash part based on omap-sham.c driver.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Cryptographic API.
+//
+// Support for Samsung S5PV210 and Exynos HW acceleration.
+//
+// Copyright (C) 2011 NetUP Inc. All rights reserved.
+// Copyright (c) 2017 Samsung Electronics Co., Ltd. All rights reserved.
+//
+// Hash part based on omap-sham.c driver.
 
 #include <linux/clk.h>
 #include <linux/crypto.h>
-- 
2.11.0
