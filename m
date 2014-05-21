From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 May 2014 09:20:15 +0100
Subject: [PATCH 3/3] ARM: sti: stih41x: Provide a proper header for this DTSI
 file
In-Reply-To: <1400660415-14720-1-git-send-email-lee.jones@linaro.org>
References: <1400660415-14720-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1400660415-14720-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also explicitly include STiH416 Clk bindings instead of relying on
inheriting them from other DTSI files which we happen to include.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih41x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x.dtsi b/arch/arm/boot/dts/stih41x.dtsi
index f5b9898..32730e5 100644
--- a/arch/arm/boot/dts/stih41x.dtsi
+++ b/arch/arm/boot/dts/stih41x.dtsi
@@ -1,3 +1,11 @@
+/*
+ * Copyright (C) 2014 STMicroelectronics Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "stih416-clock.dtsi"
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-- 
1.8.3.2
