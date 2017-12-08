From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  8 Dec 2017 12:32:49 +0100
Subject: [PATCH v9 5/6] clocksource: stm32: Update license and copyright
In-Reply-To: <20171208113250.359-1-benjamin.gaignard@st.com>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
Message-ID: <20171208113250.359-6-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt SPDX License Identifier and add STMicroelectronics
copyright

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/clocksource/timer-stm32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index c9aed2314194..21479c3cfcb9 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -1,7 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
  *
  * Inspired by time-efm32.c from Uwe Kleine-Koenig
  */
-- 
2.15.0
