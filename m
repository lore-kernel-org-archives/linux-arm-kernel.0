From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 23 Jan 2013 12:26:32 -0300
Subject: [PATCH v2 3/3] arm: mvebu: Update defconfig to select USB support
In-Reply-To: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1358954792-16160-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Lior Amsalem <alior@marvell.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index c3c6326..f8d0183 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -42,7 +42,10 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_MMC=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_RTC_CLASS=y
-- 
1.7.8.6
