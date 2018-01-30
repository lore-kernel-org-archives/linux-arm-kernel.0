From: ulfalizer@gmail.com (Ulf Magnusson)
Date: Tue, 30 Jan 2018 20:05:29 +0100
Subject: [PATCH 07/10] MIPS: BCM63XX: kconfig: Remove empty help text
In-Reply-To: <20180130190555.6577-1-ulfalizer@gmail.com>
References: <20180130190555.6577-1-ulfalizer@gmail.com>
Message-ID: <20180130190555.6577-8-ulfalizer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/mips/bcm63xx/boards/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/bcm63xx/boards/Kconfig b/arch/mips/bcm63xx/boards/Kconfig
index 6ff0a7481081..f60d96610ace 100644
--- a/arch/mips/bcm63xx/boards/Kconfig
+++ b/arch/mips/bcm63xx/boards/Kconfig
@@ -7,6 +7,5 @@ choice
 config BOARD_BCM963XX
        bool "Generic Broadcom 963xx boards"
 	select SSB
-       help
 
 endchoice
-- 
2.14.1
