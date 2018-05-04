From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  4 May 2018 11:54:45 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Relicense Buffalo files to the GPL 2.0+ /
 MIT
Message-ID: <20180504095445.30918-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This matches licensing used by other BCM5301X files and is preferred as:
1) GPL 2.0+ makes is clearly compatible with Linux kernel
2) MIT is also permissive but preferred over ISC

These files were created and ever touched by a group of four people
only: Felix, INAGAKI, Hauke and me.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
Felix, INAGAKI, Hauke: I need approve for this change from each of you.
If you are OK with it, can you reply with a line like:

Acked-by: <name> "<e-mail>"

please?
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts |  3 +--
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts | 13 +------------
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts |  3 +--
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index 8b64caabaad8..a587384f8e40 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Buffalo WZR-1750DHP
  *
  * Copyright (C) 2014 Rafa? Mi?ecki <zajec5@gmail.com>
- *
- * Licensed under the GNU/GPL. See COPYING for details.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index 87ea6ba664f5..8ea46eed26e2 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Buffalo WZR-900DHP
  *
  * Copyright (C) 2015 Rafa? Mi?ecki <zajec5@gmail.com>
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
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index 92058c73ee59..79a9633ec417 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Buffalo WXR-1900DHP
  *
  * Copyright (C) 2015 Felix Fietkau <nbd@openwrt.org>
- *
- * Licensed under the GNU/GPL. See COPYING for details.
  */
 
 /dts-v1/;
-- 
2.13.6
