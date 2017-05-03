From: andre.przywara@arm.com (Andre Przywara)
Date: Thu,  4 May 2017 00:49:36 +0100
Subject: [PATCH] Documentation: earlycon: fix Marvell Armada 3700 UART name
Message-ID: <1493855376-4341-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 3700 UART uses "ar3700_uart" for its earlycon name.
Adjust documentation to match the code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index facc20a..7ee86c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -973,7 +973,7 @@
 			A valid base address must be provided, and the serial
 			port must already be setup and configured.
 
-		armada3700_uart,<addr>
+		ar3700_uart,<addr>
 			Start an early, polled-mode console on the
 			Armada 3700 serial port at the specified
 			address. The serial port must already be setup
-- 
2.8.2
