From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  6 Feb 2013 10:06:24 -0300
Subject: [PATCH v2 4/4] ARM: mvebu: Update defconfig to select SPI flash and
 MTD support
In-Reply-To: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360155984-15397-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP DB-MV784MP-GP board has an SPI flash device.
These options allow to access that device over MTD.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Depends on patch: "arm: mvebu: i2c come back in defconfig"

 arch/arm/configs/mvebu_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 322baca..3359535 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -38,6 +38,9 @@ CONFIG_I2C=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 CONFIG_I2C_MV64XXX=y
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_M25P80=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
-- 
1.7.8.6
