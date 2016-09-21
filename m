From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 Sep 2016 00:09:35 +0200
Subject: [PATCH v2 2/6] ARM: at91: add secumod register definitions
In-Reply-To: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
References: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160921220939.27924-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add registers and bits definitions for the security module found on
sama5d2.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 include/soc/at91/atmel-secumod.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/soc/at91/atmel-secumod.h

diff --git a/include/soc/at91/atmel-secumod.h b/include/soc/at91/atmel-secumod.h
new file mode 100644
index 000000000000..7139e8eb1aca
--- /dev/null
+++ b/include/soc/at91/atmel-secumod.h
@@ -0,0 +1,20 @@
+/*
+ * Atmel Security Module register offsets and bit definitions.
+ *
+ * Copyright (C) 2016 Atmel
+ *
+ * Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_SOC_AT91_ATMEL_SECUMOD_H
+#define _LINUX_SOC_AT91_ATMEL_SECUMOD_H
+
+#define AT91_SECUMOD_RAMRDY	0x14
+#define AT91_SECUMOD_RAMRDY_READY	BIT(0)
+
+#endif /* _LINUX_SOC_AT91_ATMEL_SECUMOD_H */
+
-- 
2.9.3
