From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 27 Aug 2018 20:05:48 +0200
Subject: [PATCH V2 3/3] arm64: dts: broadcom: Add reference to Compute Module
 IO Board V3
In-Reply-To: <1535393148-24163-1-git-send-email-stefan.wahren@i2se.com>
References: <1535393148-24163-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1535393148-24163-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a reference to the dts of the Compute Module IO Board V3 in arm,
so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/Makefile                | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 1193a9e..3d98f5f 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
-			      bcm2837-rpi-3-b-plus.dtb
+			      bcm2837-rpi-3-b-plus.dtb \
+			      bcm2837-rpi-cm3-io3.dts
 
 subdir-y	+= northstar2
 subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
new file mode 100644
index 0000000..b1c4ab2
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2837-rpi-cm3-io3.dts"
-- 
2.7.4
