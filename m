From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 May 2014 09:45:24 +0100
Subject: [PATCH v2 3/3] ARM: sti: stih41x: Provide a proper header for this
 DTSI file
In-Reply-To: <1400661924-10745-1-git-send-email-lee.jones@linaro.org>
References: <1400661924-10745-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1400661924-10745-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a trivial commenting fix.  No functional changes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih41x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x.dtsi b/arch/arm/boot/dts/stih41x.dtsi
index f5b9898..5cb0e63 100644
--- a/arch/arm/boot/dts/stih41x.dtsi
+++ b/arch/arm/boot/dts/stih41x.dtsi
@@ -1,3 +1,10 @@
+/*
+ * Copyright (C) 2014 STMicroelectronics Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-- 
1.8.3.2
