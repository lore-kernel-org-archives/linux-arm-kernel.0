From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 19:12:26 +0100
Subject: [PATCH v3 6/6] ARM: at91/dt: ethernut5: use at91sam9xe.dtsi
In-Reply-To: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421172746-18727-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernut5 is actually based on an at91sam9xe, use the correct dts include.

Cc: Martin Reimann <martin.reimann@egnite.de>
Cc: Tim Schendekehl <tim.schendekehl@egnite.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/ethernut5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 8f941c2db7c6..243044343ee8 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-#include "at91sam9260.dtsi"
+#include "at91sam9xe.dtsi"
 
 / {
 	model = "Ethernut 5";
-- 
2.1.0
