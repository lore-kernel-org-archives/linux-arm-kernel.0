From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Dec 2013 14:09:31 +0100
Subject: [PATCH 2/4] ARM: dts: imx6qdl: add pingroup for enet interface in
 RMII mode
In-Reply-To: <1386853773-1319-1-git-send-email-LW@KARO-electronics.de>
References: <1386853773-1319-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1386853773-1319-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used by the TX6 modules from Ka-Ro electronics.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-pingrp.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-pingrp.h b/arch/arm/boot/dts/imx6qdl-pingrp.h
index 8d71b13..4932249 100644
--- a/arch/arm/boot/dts/imx6qdl-pingrp.h
+++ b/arch/arm/boot/dts/imx6qdl-pingrp.h
@@ -100,6 +100,17 @@
 	MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b0b0 \
 	MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN		0x1b0b0
 
+#define MX6QDL_ENET_PINGRP4					\
+	MX6QDL_PAD_ENET_MDC__ENET_MDC			0x1b0b0	\
+	MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x1b0b0	\
+	MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0		0x1b0b0	\
+	MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1		0x1b0b0	\
+	MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER		0x1b0b0	\
+	MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN		0x1b0b0	\
+	MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0		0x1b0b0	\
+	MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1		0x1b0b0	\
+	MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN		0x1b0b0
+
 #define MX6QDL_ESAI_PINGRP1 \
 	MX6QDL_PAD_ENET_RXD0__ESAI_TX_HF_CLK		0x1b030 \
 	MX6QDL_PAD_ENET_CRS_DV__ESAI_TX_CLK		0x1b030 \
-- 
1.7.2.5
