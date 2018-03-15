From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:59 +0100
Subject: [PATCH 57/60] arm: dts: kirkwood-sheevaplug-common: use
 SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-58-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Simon Baatz <gmbnomis@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
index 7196c7f3e109..0a698d3b7393 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * kirkwood-sheevaplug-common.dtsi - Common parts for Sheevaplugs
  *
  * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
- *
- * Licensed under GPLv2
  */
 
 #include "kirkwood.dtsi"
-- 
2.16.1
