From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 26 Mar 2013 07:16:28 -0300
Subject: [PATCH v2 4/4] ARM: configs: Update mvebu defconfig for thermal
In-Reply-To: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1364292988-8358-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal management driver for Armada XP/370 has been added
so we update the defconfig to reflect this.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2ec8119..fc7e8be 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -49,6 +49,8 @@ CONFIG_MTD_M25P80=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_THERMAL=y
+CONFIG_ARMADA_THERMAL=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.7.8.6
