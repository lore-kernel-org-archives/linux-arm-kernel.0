From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 30 Nov 2017 09:46:48 +0100
Subject: [PATCH v2] pinctrl: stm32: Fix copyright
Message-ID: <20171130084648.23588-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uniformize STMicroelectronics copyrights header
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c     | 3 ++-
 drivers/pinctrl/stm32/pinctrl-stm32.h     | 3 ++-
 drivers/pinctrl/stm32/pinctrl-stm32f429.c | 3 ++-
 drivers/pinctrl/stm32/pinctrl-stm32f469.c | 6 +++---
 drivers/pinctrl/stm32/pinctrl-stm32f746.c | 3 ++-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c | 6 +++---
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index a276c61be217..82bb617e8c61 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
  *
  * Heavily based on Mediatek's pinctrl driver
  */
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
index 8702a9992ce5..473a6238a27b 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.h
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
  */
 #ifndef __PINCTRL_STM32_H
 #define __PINCTRL_STM32_H
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f429.c b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
index 4bbade25acc6..663a97113c51 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32f429.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
  */
 #include <linux/init.h>
 #include <linux/of.h>
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f469.c b/drivers/pinctrl/stm32/pinctrl-stm32f469.c
index 86c8cebfa9b9..ed5397f6d7f2 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32f469.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32f469.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) Alexandre Torgue 2016
- * Author:  Alexandre Torgue <alexandre.torgue@st.com>
- * License terms:  GNU General Public License (GPL), version 2
+ * Copyright (C) STMicroelectronics 2017
+ * Author:  Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
  */
 #include <linux/init.h>
 #include <linux/of.h>
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f746.c b/drivers/pinctrl/stm32/pinctrl-stm32f746.c
index a2fae7357c36..d832aab7ebe1 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32f746.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32f746.c
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
  */
 #include <linux/init.h>
 #include <linux/of.h>
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
index e34b2b9217ce..ffe7b5271506 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) Alexandre Torgue 2017
- * Author:  Alexandre Torgue <alexandre.torgue@st.com>
- * License terms:  GNU General Public License (GPL), version 2
+ * Copyright (C) STMicroelectronics 2017
+ * Author:  Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
  */
 #include <linux/init.h>
 #include <linux/of.h>
-- 
2.15.0
