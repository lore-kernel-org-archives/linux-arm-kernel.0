From: info@gerhard-bertelsmann.de (Gerhard Bertelsmann)
Date: Wed, 16 Sep 2015 13:21:20 +0200
Subject: [PATCH v8 2/4] can: Allwinner A10/A20 CAN Controller support -
 Defconfig
In-Reply-To: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
Message-ID: <1442402482-7118-3-git-send-email-info@gerhard-bertelsmann.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defconfig multi_v7 for Allwinner A10/A20 CAN driver

Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
---

 arch/arm/configs/multi_v7_defconfig                |   1 +
 1 file changed, 1 insertions(+)


diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7f..14eb6b9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -153,6 +153,7 @@ CONFIG_CAN_DEV=y
 CONFIG_CAN_AT91=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
+CONFIG_CAN_SUN4I=y
 CONFIG_BT=m
 CONFIG_BT_MRVL=m
 CONFIG_BT_MRVL_SDIO=m
