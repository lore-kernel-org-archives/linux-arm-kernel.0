From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 14:33:10 -0700
Subject: [PATCH 1/9] ARM: dt: add header to define GPIO flags
In-Reply-To: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360791198-29462-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Many GPIO device tree bindings use the same flags. Create a header to
define those.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/gpio.h |   10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm/boot/dts/gpio.h

diff --git a/arch/arm/boot/dts/gpio.h b/arch/arm/boot/dts/gpio.h
new file mode 100644
index 0000000..4c9da69
--- /dev/null
+++ b/arch/arm/boot/dts/gpio.h
@@ -0,0 +1,10 @@
+/*
+ * This header provides constants for most GPIO bindings.
+ *
+ * Most GPIO bindings include a flags cell as part of the GPIO specifier.
+ * In most cases, the format of the flags cell uses the standard values
+ * defined in this header.
+ */
+
+#define GPIO_ACTIVE_HIGH 0
+#define GPIO_ACTIVE_LOW 1
-- 
1.7.10.4
