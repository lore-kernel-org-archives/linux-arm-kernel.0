From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 13 Nov 2018 20:46:26 +0100
Subject: [PATCH] ARM: dts: exynos: Clarify comment explaining purpose of
 Odroid XU3 DTSI
Message-ID: <20181113194626.11654-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two common DTSI files for Exynos5422 Odroid XU3 family of
boards.  One is shared between all of them (XU3, XU3-Lite, XU4 and HC1)
and the second skips HC1.  Document this in the files.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2fac4baf1eb4..2ee194cfbc96 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Hardkernel Odroid XU3/XU4/HC1 boards core device tree source
+ * Hardkernel Odroid XU3/XU3-Lite/XU4/HC1 boards core device tree source
  *
  * Copyright (c) 2017 Marek Szyprowski
  * Copyright (c) 2013-2017 Samsung Electronics Co., Ltd.
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index e522edb2bb82..f63ac17990cc 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Hardkernel Odroid XU3 board device tree source
+ * Hardkernel Odroid XU3/XU3-Lite/XU4 boards common device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
-- 
2.17.1
