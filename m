From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 Aug 2016 18:11:06 +0200
Subject: [PATCH 3/5] ARM: at91: add secumod register definitions
In-Reply-To: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
References: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160831161108.8780-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add registers and bits definitions for the security module found on
sama5d2.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 include/soc/at91/atmel-secumod.h | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 include/soc/at91/atmel-secumod.h

diff --git a/include/soc/at91/atmel-secumod.h b/include/soc/at91/atmel-secumod.h
new file mode 100644
index 000000000000..7b5c238eb69f
--- /dev/null
+++ b/include/soc/at91/atmel-secumod.h
@@ -0,0 +1,46 @@
+/*
+ * Atmel SFR (Special Function Registers) register offsets and bit definitions.
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
+#define AT91_SECUMOD_CR		0x00
+#define AT91_SECUMOD_SYSR	0x04
+#define AT91_SECUMOD_SR		0x08
+#define AT91_SECUMOD_ASR	0x0C
+#define AT91_SECUMOD_SCR	0x10
+
+#define AT91_SECUMOD_RAMRDY	0x14
+#define AT91_SECUMOD_RAMRDY_READY	BIT(0)
+
+#define AT91_SECUMOD_PIOBU0	0x18
+#define AT91_SECUMOD_PIOBU1	0x1C
+#define AT91_SECUMOD_PIOBU2	0x20
+#define AT91_SECUMOD_PIOBU3	0x24
+#define AT91_SECUMOD_PIOBU4	0x28
+#define AT91_SECUMOD_PIOBU5	0x2C
+#define AT91_SECUMOD_PIOBU6	0x30
+#define AT91_SECUMOD_PIOBU7	0x34
+#define AT91_SECUMOD_JTAGCR	0x68
+#define AT91_SECUMOD_DYSTUNE	0x6C
+#define AT91_SECUMOD_SRCKEY	0x70
+#define AT91_SECUMOD_RAMACC	0x74
+#define AT91_SECUMOD_RAMACCSR	0x78
+#define AT91_SECUMOD_BMPR	0x7C
+#define AT91_SECUMOD_NMPR	0x80
+#define AT91_SECUMOD_NIEPR	0x84
+#define AT91_SECUMOD_NIDPR	0x88
+#define AT91_SECUMOD_NIMPR	0x8C
+#define AT91_SECUMOD_WKPR	0x90
+
+#endif /* _LINUX_SOC_AT91_ATMEL_SECUMOD_H */
+
-- 
2.9.3
