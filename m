From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Dec 2013 14:09:32 +0100
Subject: [PATCH 3/4] ARM: dts: imx6qdl: add new pingroup for audmux
In-Reply-To: <1386853773-1319-1-git-send-email-LW@KARO-electronics.de>
References: <1386853773-1319-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1386853773-1319-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used by the TX6 modules from Ka-Ro electronics.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-pingrp.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-pingrp.h b/arch/arm/boot/dts/imx6qdl-pingrp.h
index 4932249..68f18e9 100644
--- a/arch/arm/boot/dts/imx6qdl-pingrp.h
+++ b/arch/arm/boot/dts/imx6qdl-pingrp.h
@@ -32,6 +32,12 @@
 	MX6QDL_PAD_EIM_D25__AUD5_RXC			0x130b0 \
 	MX6QDL_PAD_DISP0_DAT19__AUD5_RXD		0x130b0
 
+#define MX6QDL_AUDMUX_PINGRP5 \
+	MX6QDL_PAD_KEY_ROW1__AUD5_RXD			0x130b0 \
+	MX6QDL_PAD_KEY_COL0__AUD5_TXC			0x130b0 \
+	MX6QDL_PAD_KEY_ROW0__AUD5_TXD			0x110b0 \
+	MX6QDL_PAD_KEY_COL1__AUD5_TXFS			0x130b0
+
 #define MX6QDL_ECSPI1_PINGRP1 \
 	MX6QDL_PAD_EIM_D17__ECSPI1_MISO			0x100b1 \
 	MX6QDL_PAD_EIM_D18__ECSPI1_MOSI			0x100b1 \
-- 
1.7.2.5
