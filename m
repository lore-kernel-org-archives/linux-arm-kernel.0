From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:13 -0600
Subject: [PATCH v3 01/30] usb: ohci-pxa27x: add explicit include of hardware.h
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

ohci-pxa27x needs cpu_is_pxa3xx macro.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/usb/host/ohci-pxa27x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 6313e44..4db399c 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -23,6 +23,7 @@
 #include <linux/signal.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <mach/hardware.h>
 #include <mach/ohci.h>
 #include <mach/pxa3xx-u2d.h>
 
-- 
1.7.5.4
