From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 17 Jul 2015 13:04:03 +0100
Subject: [PATCH 2/6] mailbox: dt-bindings: Add shared [driver <=> device tree]
 defines
In-Reply-To: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1437134647-28298-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This header is currently only used for defines pertaining to data
direction i.e. Rx, Tx or Loopback.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/dt-bindings/mailbox/mailbox.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/mailbox/mailbox.h

diff --git a/include/dt-bindings/mailbox/mailbox.h b/include/dt-bindings/mailbox/mailbox.h
new file mode 100644
index 0000000..82e929a
--- /dev/null
+++ b/include/dt-bindings/mailbox/mailbox.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MAILBOX_CONTROLLER_DT_BINDINGS_H
+#define __MAILBOX_CONTROLLER_DT_BINDINGS_H
+
+#define MBOX_TX		0x1
+#define MBOX_RX		0x2
+#define MBOX_LOOPBACK	(MBOX_RX | MBOX_TX)
+
+#endif /* __MAILBOX_CONTROLLER_DT_BINDINGS_H */
-- 
1.9.1
