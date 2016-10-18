From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 18 Oct 2016 10:39:07 +0100
Subject: [PATCH v10 02/11] MAINTAINERS: Add st slim core rproc driver to STi
 section.
In-Reply-To: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1476783556-2501-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the slim core rproc driver to the STi section
of the MAINTAINERS file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7..78b7f8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1784,6 +1784,7 @@ F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/remoteproc/st_remoteproc.c
+F:	drivers/remoteproc/st_slim_rproc.c
 F:	drivers/reset/sti/
 F:	drivers/rtc/rtc-st-lpc.c
 F:	drivers/tty/serial/st-asc.c
@@ -1792,6 +1793,7 @@ F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
 F:	drivers/watchdog/st_lpc_wdt.c
 F:	drivers/ata/ahci_st.c
+F:	include/linux/remoteproc/st_slim_rproc.h
 
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
-- 
1.9.1
