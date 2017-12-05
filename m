From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue,  5 Dec 2017 15:51:07 +0100
Subject: [PATCH] media: platform: stm32: Adopt SPDX identifier
Message-ID: <20171205145107.17785-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPDX identifiers to files under stm32 directory

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/media/platform/stm32/stm32-cec.c  | 5 +----
 drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-cec.c b/drivers/media/platform/stm32/stm32-cec.c
index 0e5aa17bdd40..7c496bc1cf38 100644
--- a/drivers/media/platform/stm32/stm32-cec.c
+++ b/drivers/media/platform/stm32/stm32-cec.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * STM32 CEC driver
  * Copyright (C) STMicroelectronics SA 2017
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index ac4c450a6c7d..519952bec6d5 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STM32 Digital Camera Memory Interface
  *
@@ -5,7 +6,6 @@
  * Authors: Yannick Fertre <yannick.fertre@st.com>
  *          Hugues Fruchet <hugues.fruchet@st.com>
  *          for STMicroelectronics.
- * License terms:  GNU General Public License (GPL), version 2
  *
  * This driver is based on atmel_isi.c
  *
-- 
2.15.0
