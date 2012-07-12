From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:01:49 +0800
Subject: [PATCH 09/12] USB: chipidea: add -DDEBUG if CONFIG_USB_CHIPIDEA_DEBUG
In-Reply-To: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342076512-19207-10-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 5c66d9c..3f56b76 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_USB_CHIPIDEA_DEBUG) := -DDEBUG
+
 obj-$(CONFIG_USB_CHIPIDEA)		+= ci_hdrc.o
 
 ci_hdrc-y				:= core.o
-- 
1.7.9.5
