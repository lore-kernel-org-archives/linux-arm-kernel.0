From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 31 Mar 2015 18:24:56 +0200
Subject: [PATCH v4 15/15] MAINTAINERS: Add entry for STM32 MCUs
In-Reply-To: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1427819096-31109-16-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINER entry covering all STM32 machine and drivers files.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..08c08c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1467,6 +1467,14 @@ F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
 F:	drivers/ata/ahci_st.c
 
+ARM/STM32 ARCHITECTURE
+M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git
+N:	stm32
+F:	drivers/clocksource/armv7m_systick.c
+
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.9.1
