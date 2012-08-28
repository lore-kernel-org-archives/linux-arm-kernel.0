From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:15 +0800
Subject: [PATCH v2 09/11] USB: chipidea: add -DDEBUG if
 CONFIG_USB_CHIPIDEA_DEBUG
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-10-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 57e510f..d92ca32 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_USB_CHIPIDEA_DEBUG) := -DDEBUG
+
 obj-$(CONFIG_USB_CHIPIDEA)		+= ci_hdrc.o
 
 ci_hdrc-y				:= core.o
-- 
1.7.9.5
