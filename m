From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 16:07:17 +0100
Subject: [PATCH 36/36] arm: dts: armada-370-seagate-personal-cloud*: use
 SPDX-License-Identifier
In-Reply-To: <20180315150717.10588-1-gregory.clement@bootlin.com>
References: <20180315150717.10588-1-gregory.clement@bootlin.com>
Message-ID: <20180315150717.10588-37-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description.

Cc:Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts | 5 +----
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts      | 5 +----
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi     | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
index 3c91f9821c89..5ee572dc9242 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for Seagate Personal Cloud NAS 2-Bay (Armada 370 SoC).
  *
  * Copyright (C) 2015 Seagate
  *
  * Author: Simon Guinot <simon.guinot@sequanux.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
index aad39e97af43..578b54b39c8f 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree file for Seagate Personal Cloud NAS (Armada 370 SoC).
  *
  * Copyright (C) 2015 Seagate
  *
  * Author: Simon Guinot <simon.guinot@sequanux.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index d079a89ee5a2..a624b2371fb6 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree common file for the Seagate Personal Cloud NAS 1 and 2-Bay
  * (Armada 370 SoC).
@@ -5,10 +6,6 @@
  * Copyright (C) 2015 Seagate
  *
  * Author: Simon Guinot <simon.guinot@sequanux.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
-- 
2.16.1
