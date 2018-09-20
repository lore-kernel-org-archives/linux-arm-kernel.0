From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 20 Sep 2018 13:37:47 +0200
Subject: [PATCH] ARM: dts: BCM53573: Relicense Tenda AC9 file to the GPL 2.0+
 / MIT
Message-ID: <20180920113747.26832-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This matches licensing used by most of BCM5301X files and is preferred as:
1) GPL 2.0+ makes it clearly compatible with Linux kernel
2) MIT is also permissive but preferred over ISC

This file was fully developed by me.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 19e61b5b066c..e15e2a1e9d8c 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
-- 
2.13.7
