From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 15 Nov 2018 23:29:40 +0100
Subject: [PATCH 3/3] arm64: dts: broadcom: Add reference to RPi 3 A+
In-Reply-To: <1542320980-2842-1-git-send-email-stefan.wahren@i2se.com>
References: <1542320980-2842-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542320980-2842-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a reference to the dts of the Raspberry Pi 3 A+,
so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
new file mode 100644
index 0000000..f0ec56a
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2837-rpi-3-a-plus.dts"
-- 
2.7.4
