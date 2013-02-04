From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  4 Feb 2013 13:38:08 -0300
Subject: [PATCH 2/2] ARM: mvebu: Update defconfig to select SPI support
In-Reply-To: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1359995888-2385-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 4e6f0ce..e243451 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -40,6 +40,8 @@ CONFIG_MWIFIEX_SDIO=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_I2C=y
+CONFIG_SPI=y
+CONFIG_SPI_ORION=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
-- 
1.7.8.6
