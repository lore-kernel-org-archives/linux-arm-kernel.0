From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 20 Feb 2015 19:01:17 +0100
Subject: [PATCH v2 18/18] MAINTAINERS: Add entry for STM32 MCUs
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1424455277-29983-19-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINER entry covering all STM32 machine and drivers files.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d66a97d..559cd45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1448,6 +1448,13 @@ F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
 F:	drivers/ata/ahci_st.c
 
+ARM/STM32 ARCHITECTURE
+M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+N:	stm32
+F:	drivers/clocksource/armv7m_systick.c
+
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.9.1
