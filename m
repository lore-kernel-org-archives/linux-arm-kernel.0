From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  6 Nov 2016 20:25:34 +0100
Subject: [PATCH] ARM64: dts: amlogic: Reorder copyrights for meson-gx
In-Reply-To: <1475595430-30075-2-git-send-email-narmstrong@baylibre.com>
References: <1475595430-30075-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <1478460334-17644-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

meson-gx.dtsi was directly derived from meson-gxbb.dtsi, so keep the
copyrights in chronological order to not give a wrong impression.

Fixes: c328666d58aa ("ARM64: dts: amlogic: Add Meson GX dtsi from GXBB")
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index fd1d0deef889..0b57d037974c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -1,12 +1,12 @@
 /*
+ * Copyright (c) 2016 Andreas F?rber
+ *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  *
  * Copyright (c) 2016 Endless Computers, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  *
- * Copyright (c) 2016 Andreas F?rber
- *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
-- 
2.6.6
