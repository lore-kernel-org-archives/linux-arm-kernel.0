From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:34:41 +0100
Subject: [PATCH 6/7] ARM: multi_v7_defconfig: add NXP FlexCAN IP support
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Message-ID: <20180318203442.19759-6-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable FlexCAN support as module by default. FlexCAN can be found
on various NXP designs such as the i.MX and Vybrid SoC family.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 984e509d41bf..61968bd6cccc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -174,6 +174,7 @@ CONFIG_CAN_RAW=y
 CONFIG_CAN_BCM=y
 CONFIG_CAN_DEV=y
 CONFIG_CAN_AT91=m
+CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
-- 
2.16.2
