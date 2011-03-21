From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 21 Mar 2011 15:36:50 +0100
Subject: Enable UART3 on TX28
Message-ID: <1300718213-9908-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+	/* UART3 */
+	MX28_PAD_AUART3_RX__AUART3_RX,
+	MX28_PAD_AUART3_TX__AUART3_TX,
+	MX28_PAD_AUART3_RTS__AUART3_RTS,
+	MX28_PAD_AUART3_CTS__AUART3_CTS,
+
 	/* CAN */
 	MX28_PAD_GPMI_RDY2__CAN0_TX,
 	MX28_PAD_GPMI_RDY3__CAN0_RX,
@@ -322,6 +328,7 @@
 
 	mx28_add_duart(); /* UART1 */
 	mx28_add_auart(1); /* UART2 */
+	mx28_add_auart(3); /* UART3 */
 
 	tx28_add_fec0();
 	/* spi via ssp will be added when available */
@@ -343,6 +350,7 @@
 
 	mx28_add_duart(); /* UART1 */
 	mx28_add_auart(1); /* UART2 */
+	mx28_add_auart(3); /* UART3 */
 
 	tx28_add_fec0();
 	/* spi via ssp will be added later */
