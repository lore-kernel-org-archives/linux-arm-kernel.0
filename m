From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 29 Nov 2017 16:25:23 +0100
Subject: [PATCH v3] arch: arm: mach-stm32: Fix copyright
Message-ID: <20171129152523.5262-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uniformize STMicroelectronics copyrights header
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/mach-stm32/board-dt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index e918686e4191..77899ae4b8ed 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -1,5 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics SA 2017
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  * License terms:  GNU General Public License (GPL), version 2
  */
-- 
2.15.0
