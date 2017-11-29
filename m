From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 29 Nov 2017 15:21:42 +0100
Subject: [PATCH] i2c: stm32: Fix copyrights
Message-ID: <20171129142142.23183-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uniformize STMicroelectronics copyrights headers

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/i2c/busses/i2c-stm32.h   | 1 +
 drivers/i2c/busses/i2c-stm32f4.c | 1 +
 drivers/i2c/busses/i2c-stm32f7.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-stm32.h b/drivers/i2c/busses/i2c-stm32.h
index dab51761f8c5..490f6e6bebc2 100644
--- a/drivers/i2c/busses/i2c-stm32.h
+++ b/drivers/i2c/busses/i2c-stm32.h
@@ -2,6 +2,7 @@
  * i2c-stm32.h
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics SA 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * License terms:  GNU General Public License (GPL), version 2
diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index 4ec108496f15..f399ef344d30 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -6,6 +6,7 @@
  * http://www.st.com/resource/en/reference_manual/DM00031020.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2016
+ * Copyright (C) STMicroelectronics SA 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-st.c
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index d4a6e9c2e9aa..e85f4b7aedf6 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -7,6 +7,7 @@
  * http://www.st.com/resource/en/reference_manual/dm00124865.pdf
  *
  * Copyright (C) M'boumba Cedric Madianga 2017
+ * Copyright (C) STMicroelectronics SA 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
  * This driver is based on i2c-stm32f4.c
-- 
2.15.0
