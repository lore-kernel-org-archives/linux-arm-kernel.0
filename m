From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 30 Nov 2017 09:48:04 +0100
Subject: [PATCH v2] watchdog: stm32: Fix copyright
Message-ID: <20171130084804.23693-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uniformize STMicroelectronics copyrights header
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/watchdog/stm32_iwdg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index be64a8699de3..c97ad5619cb0 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -1,12 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STM32 Independent Watchdog
  *
- * Copyright (C) Yannick Fertre 2017
- * Author: Yannick Fertre <yannick.fertre@st.com>
+ * Copyright (C) STMicroelectronics 2017
+ * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
  *
  * This driver is based on tegra_wdt.c
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/clk.h>
-- 
2.15.0
