From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 25 Dec 2017 11:40:10 +0100
Subject: [PATCH 2/5] ARM: dts: s3c24xx: Add SPDX license identifier
In-Reply-To: <1514198413-4358-1-git-send-email-krzk@kernel.org>
References: <1514198413-4358-1-git-send-email-krzk@kernel.org>
Message-ID: <1514198413-4358-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL v2.0 license with a SPDX license indentifier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi | 5 +----
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 5 +----
 arch/arm/boot/dts/s3c2416.dtsi         | 5 +----
 arch/arm/boot/dts/s3c24xx.dtsi         | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
index 6274359fb323..92439ee5d7de 100644
--- a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung S3C2416 pinctrl settings
  *
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/pinctrl/samsung.h>
diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index f257926c13b7..a1c9d8c695cc 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG SMDK2416 board device tree source
  *
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 80f007550324..3c7385cab248 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S3C2416 SoC device tree source
  *
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/clock/s3c2443.h>
diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
index 5ed43b857cc4..34c7fe6751cf 100644
--- a/arch/arm/boot/dts/s3c24xx.dtsi
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S3C24XX family device tree source
  *
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "skeleton.dtsi"
-- 
2.7.4
