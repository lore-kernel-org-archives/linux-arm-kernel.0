From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:08 +0200
Subject: [PATCH v4 10/28] Documentation: kernel-parameters: Document owl
 earlycon
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-11-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "owl" earlycon option to kernel-parameters.txt.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Extended help text and commit message (Jonathan)
 
 v1 -> v2 -> v3: unchanged
 
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 042aa5e9c47d..e2fb7a87bc84 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -961,6 +961,12 @@
 			must already be setup and configured. Options are not
 			yet supported.
 
+		owl,<addr>
+			Start an early, polled-mode console on a serial port
+			of an Actions Semi SoC, such as S500 or S900, at the
+			specified address. The serial port must already be
+			setup and configured. Options are not yet supported.
+
 		smh	Use ARM semihosting calls for early console.
 
 		s3c2410,<addr>
-- 
2.12.3
