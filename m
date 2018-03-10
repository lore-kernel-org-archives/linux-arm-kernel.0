From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 10 Mar 2018 22:18:41 +0900
Subject: [PATCH] arm64: dts: uniphier: use proper SPDX-License-Identifier style
Message-ID: <1520687921-31521-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/process/license-rules.rst, move the SPDX
License Identifier to the very top of the file.  I used C++ comment
style not only for the SPDX line but for the entire block because
this seems Linus' preference [1].  I also dropped the parentheses to
follow the examples in that document.

[1] https://lkml.org/lkml/2017/11/25/133

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 16 +++++++---------
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 16 +++++++---------
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    | 14 ++++++--------
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 14 ++++++--------
 8 files changed, 50 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 0feec41..9b4dc41 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -1,12 +1,10 @@
-/*
- * Device Tree Source for UniPhier LD11 Global Board
- *
- * Copyright (C) 2016-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD11 Global Board
+//
+// Copyright (C) 2016-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+//           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 /dts-v1/;
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index dacdea5..b8f6273 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD11 Reference Board
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD11 Reference Board
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld11.dtsi"
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index f9014c8..5f2da73 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD11 SoC
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD11 SoC
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 6bee22e..fe6608e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -1,12 +1,10 @@
-/*
- * Device Tree Source for UniPhier LD20 Global Board
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD20 Global Board
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+//           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 /dts-v1/;
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 092574d..2c1a92f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD20 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD20 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld20.dtsi"
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 3d5ca4b..458b5b8 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD20 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD20 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 3c71087..e62d068 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs3 Reference Board
- *
- * Copyright (C) 2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs3 Reference Board
+//
+// Copyright (C) 2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pxs3.dtsi"
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 234fc58..b537a3c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs3 SoC
- *
- * Copyright (C) 2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs3 SoC
+//
+// Copyright (C) 2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
-- 
2.7.4
