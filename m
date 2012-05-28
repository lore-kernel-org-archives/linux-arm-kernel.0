From: rubini@gnudd.com (Alessandro Rubini)
Date: Mon, 28 May 2012 18:37:48 +0200
Subject: [PATCH V2 4/6] serial: use the new linux/sizes.h
In-Reply-To: <cover.1338222460.git.rubini@gnudd.com>
References: <cover.1338222460.git.rubini@gnudd.com>
Message-ID: <f9488ee124f2101fc284d7375e545e7d96c93f1c.1338222461.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4ad721f..d394b93 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -53,9 +53,9 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/sizes.h>
 
 #include <asm/io.h>
-#include <asm/sizes.h>
 
 #define UART_NR			14
 
-- 
1.7.7.2
