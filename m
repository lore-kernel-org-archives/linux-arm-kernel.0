From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Jan 2018 21:29:19 +0100
Subject: [PATCH] ARM: dts: exynos: Add SPDX license identifiers
Message-ID: <20180130202919.30026-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few files missed recent conversion of GPL v2.0 license statements to
SPDX identifiers

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi | 5 +----
 arch/arm/boot/dts/exynos-syscon-restart.dtsi      | 5 +----
 arch/arm/boot/dts/exynos5800-peach-pi.dts         | 5 +----
 arch/arm/boot/dts/exynos5800.dtsi                 | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
index 25186ac4188d..1dbf3bbff8d3 100644
--- a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
+++ b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos SoC MFC (Video Codec) reserved memory common definition.
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 / {
diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
index 09a2040054ed..4b3dd0549a54 100644
--- a/arch/arm/boot/dts/exynos-syscon-restart.dtsi
+++ b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos SoC syscon reboot/poweroff nodes common definition.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 / {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 0029ec27819c..c8a66a12dbeb 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Google Peach Pi Rev 10+ board device tree source
  *
  * Copyright (c) 2014 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 9ddb6bacac5a..57d3b319fd65 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5800 SoC device tree source
  *
@@ -7,10 +8,6 @@
  * SAMSUNG EXYNOS5800 SoC device nodes are listed in this file.
  * EXYNOS5800 based board files can include this file and provide
  * values for board specfic bindings.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos5420.dtsi"
-- 
2.11.0
