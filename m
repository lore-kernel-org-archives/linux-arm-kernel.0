From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:24 +0100
Subject: [PATCH 07/11] Documentation: kernel-parameters: Document owl earlycon
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-8-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 01f5788..c741166 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -952,6 +952,12 @@
 			must already be setup and configured. Options are not
 			yet supported.
 
+		owl,<addr>
+			Start an early, polled-mode console on an Owl serial
+			port at the specified address. The serial port must
+			already be setup and configured. Options are not yet
+			supported.
+
 		smh	Use ARM semihosting calls for early console.
 
 		s3c2410,<addr>
-- 
2.10.2
