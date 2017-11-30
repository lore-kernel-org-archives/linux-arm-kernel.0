From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 30 Nov 2017 09:41:08 +0100
Subject: [PATCH v2] clk: stm32-h7: fix copyright
Message-ID: <20171130084108.23083-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uniformize STMicroelectronics copyrights header
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32h7.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
index 61c3e40507d3..db2b162c0d4c 100644
--- a/drivers/clk/clk-stm32h7.c
+++ b/drivers/clk/clk-stm32h7.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) Gabriel Fernandez 2017
- * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
- *
- * License terms: GPL V2.0.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) STMicroelectronics 2017
+ * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
  */
 
 #include <linux/clk.h>
-- 
2.15.0
