From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  4 May 2018 12:03:24 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Relicense Asus RT-AC87U file to the GPL
 2.0+ / MIT
Message-ID: <20180504100324.31847-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This matches licensing used by other BCM5301X files and is preferred as:
1) GPL 2.0+ makes is clearly compatible with Linux kernel
2) MIT is also permissive but preferred over ISC

This file were created and ever touched by a group of three people only:
?lvaro, Hauke and me.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
?lvaro, Hauke: I need approve for this change from each of you. If you
are OK with it, can you reply with an Acked-by, please?
---
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index df473cc41572..22271818f901 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Asus RT-AC87U
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
-- 
2.13.6
