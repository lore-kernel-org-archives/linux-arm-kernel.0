From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 30 Nov 2017 09:43:57 +0100
Subject: [PATCH v2] i2c: stm32: Fix copyrights
Message-ID: <20171130084357.23327-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uniformize STMicroelectronics copyrights headers
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 drivers/i2c/busses/i2c-stm32.h   | 3 ++-
 drivers/i2c/busses/i2c-stm32f4.c | 3 ++-
 drivers/i2c/busses/i2c-stm32f7.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32.h b/drivers/i2c/busses/i2c-stm32.h
index dab51761f8c5..d4f9cef251ac 100644
--- a/drivers/i2c/busses/i2c-stm32.h
+++ b/drivers/i2c/busses/i2c-stm32.h
@@ -1,10 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-stm32.h
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #ifndef _I2C_STM32_H
diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index 4ec108496f15..47c8d00de53f 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STMicroelectronics STM32 I2C controller
  *
@@ -6,11 +7,11 @@
  * http://www.st.com/resource/en/reference_manual/DM00031020.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2016
+ * Copyright (C) STMicroelectronics 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-st.c
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/clk.h>
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index d4a6e9c2e9aa..b445b3bb0bb1 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STMicroelectronics STM32F7 I2C controller
  *
@@ -7,11 +8,11 @@
  * http://www.st.com/resource/en/reference_manual/dm00124865.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-stm32f4.c
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.15.0
