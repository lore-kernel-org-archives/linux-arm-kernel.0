From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Jul 2016 09:54:20 +0100
Subject: [PATCH v6 02/18] MAINTAINERS: Add st slim core rproc driver to STi
 section.
In-Reply-To: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1467795276-21725-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the slim core rproc driver to the STi section
of the MAINTAINERS file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 952fd2a..7af90e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1713,6 +1713,7 @@ F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/remoteproc/st_remoteproc.c
+F:	drivers/remoteproc/st_slim_rproc.c
 F:	drivers/reset/sti/
 F:	drivers/rtc/rtc-st-lpc.c
 F:	drivers/tty/serial/st-asc.c
@@ -1721,6 +1722,7 @@ F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
 F:	drivers/watchdog/st_lpc_wdt.c
 F:	drivers/ata/ahci_st.c
+F:	include/linux/remoteproc/st_slim_rproc.h
 
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
-- 
1.9.1
