From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 21 Jan 2018 17:23:17 +0100
Subject: [PATCH] arm64: dts: actions: Convert to new-style SPDX license
 identifiers
Message-ID: <20180121162317.24361-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move SPDX-License-Identifier to the top and add one for the Makefile.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/actions/Makefile              | 2 ++
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 3 +--
 arch/arm64/boot/dts/actions/s900.dtsi             | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
index d8b923480f5a..b57fd2372ecd 100644
--- a/arch/arm64/boot/dts/actions/Makefile
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+
 dtb-$(CONFIG_ARCH_ACTIONS) += s700-cubieboard7.dtb
 
 dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index e1dcedf69733..47990e5a10a2 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2017 Andreas F?rber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index dd086a80b795..094a35ccfc56 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2017 Andreas F?rber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.13.6
