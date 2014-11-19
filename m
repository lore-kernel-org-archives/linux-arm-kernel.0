From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 19 Nov 2014 08:44:54 +0000
Subject: [PATCH] MAINTAINERS: Add ahci_st.c to ARCH/STI architecture
Message-ID: <1416386694-7402-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the ahci_st.c driver found on STMicroelectronics
stih41x consumer electronics SoC's into the STI arch section
of the maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9b..2b0a53e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1430,6 +1430,7 @@ F:	drivers/tty/serial/st-asc.c
 F:	drivers/usb/dwc3/dwc3-st.c
 F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
+F:	drivers/ata/ahci_st.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
