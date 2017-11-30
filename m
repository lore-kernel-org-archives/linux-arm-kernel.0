From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 30 Nov 2017 09:42:49 +0100
Subject: [PATCH v2] dma: stm32: Fix copyright
Message-ID: <20171130084249.23196-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uniformize STMicroelectronics copyrights header
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 drivers/dma/stm32-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 786fc8fcc38e..e3187ee9afe9 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1,12 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STM32 DMA controller
  *
  * Inspired by dma-jz4740.c and tegra20-apb-dma.c
  *
  * Copyright (C) M'boumba Cedric Madianga 2015
+ * Copyright (C) STMicroelectronics 2017
  * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/clk.h>
-- 
2.15.0
