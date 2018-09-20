From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 20 Sep 2018 13:18:47 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Relicense BCM47081/BCM4709 files to the
 GPL 2.0+ / MIT
Message-ID: <20180920111847.25513-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This matches licensing used by other BCM5301X files and is preferred as:
1) GPL 2.0+ makes it clearly compatible with Linux kernel
2) MIT is also permissive but preferred over ISC

Both files were fully developed by me. Commits touching them were signed
by Florian and Hauke due to submitting process only.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47081.dtsi | 13 +------------
 arch/arm/boot/dts/bcm4709.dtsi  |  3 +--
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47081.dtsi b/arch/arm/boot/dts/bcm47081.dtsi
index 9829d044aaf4..ed13af028528 100644
--- a/arch/arm/boot/dts/bcm47081.dtsi
+++ b/arch/arm/boot/dts/bcm47081.dtsi
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for BCM47081 SoC.
  *
  * Copyright ? 2014 Rafa? Mi?ecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include "bcm5301x.dtsi"
diff --git a/arch/arm/boot/dts/bcm4709.dtsi b/arch/arm/boot/dts/bcm4709.dtsi
index c645fea2b7f7..e1bb8661955f 100644
--- a/arch/arm/boot/dts/bcm4709.dtsi
+++ b/arch/arm/boot/dts/bcm4709.dtsi
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 #include "bcm4708.dtsi"
-- 
2.13.7
