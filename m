From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 11 Feb 2014 20:44:01 +0100
Subject: [PATCH 3/3] arm: at91sam9260_9g20: refresh configuration
In-Reply-To: <1392147841-7815-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1392147841-7815-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1392147841-7815-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_EMBEDDED as it it useful for that board.

Also select CONFIG_MTD_UBI to really enable UBIfs (CONFIG_FS_UBIFS depends on
it).

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91sam9260_9g20_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/at91sam9260_9g20_defconfig b/arch/arm/configs/at91sam9260_9g20_defconfig
index 2c879bc29f86..9d35cb2ddceb 100644
--- a/arch/arm/configs/at91sam9260_9g20_defconfig
+++ b/arch/arm/configs/at91sam9260_9g20_defconfig
@@ -3,6 +3,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -60,6 +61,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
+CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-- 
1.8.3.2
