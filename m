From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 8 Dec 2017 16:53:11 +0100
Subject: [PATCH] dt-bindings: pinctrl: stm32: fix copyright and adopt SPDX
 identifier
Message-ID: <1512748391-22004-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing copyright and add SPDX identifier.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/include/dt-bindings/pinctrl/stm32-pinfunc.h b/include/dt-bindings/pinctrl/stm32-pinfunc.h
index b8dfe31..b5a2174 100644
--- a/include/dt-bindings/pinctrl/stm32-pinfunc.h
+++ b/include/dt-bindings/pinctrl/stm32-pinfunc.h
@@ -1,3 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
+ * Author: Torgue Alexandre <alexandre.torgue@st.com> for STMicroelectronics.
+ */
+
 #ifndef _DT_BINDINGS_STM32_PINFUNC_H
 #define _DT_BINDINGS_STM32_PINFUNC_H
 
-- 
2.7.4
