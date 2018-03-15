From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 16:07:16 +0100
Subject: [PATCH 35/36] arm: dts: armada-370-seagate-nas-*: use
 SPDX-License-Identifier
In-Reply-To: <20180315150717.10588-1-gregory.clement@bootlin.com>
References: <20180315150717.10588-1-gregory.clement@bootlin.com>
Message-ID: <20180315150717.10588-36-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description.

Cc: Vincent Donnefort <vdonnefort@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  | 5 +----
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 5 +----
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
index fef0110a8d8a..8dd242e668e6 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for Seagate NAS 2-Bay (Armada 370 SoC).
  *
  * Copyright (C) 2015 Seagate
  *
  * Author: Vincent Donnefort <vdonnefort@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index eb6af53b4954..3cf70c72c5ca 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for Seagate NAS 4-Bay (Armada 370 SoC).
  *
  * Copyright (C) 2015 Seagate
  *
  * Author: Vincent Donnefort <vdonnefort@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index e9a5b952afc0..a5206db0ebbd 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree common file for the Seagate NAS 2 and 4-bay (Armada 370 SoC).
  *
  * Copyright (C) 2015 Seagate
  *
  * Author: Vincent Donnefort <vdonnefort@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
-- 
2.16.1
