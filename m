From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  6 Feb 2013 10:06:22 -0300
Subject: [PATCH v2 2/4] ARM: mvebu: Update defconfig to select SPI support
In-Reply-To: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360155984-15397-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>
Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 43a0dbf..322baca 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -35,6 +35,8 @@ CONFIG_MARVELL_PHY=y
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
