From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 15 Jan 2013 06:54:30 -0300
Subject: [PATCH 6/6] arm: mvebu: Update defconfig to select USB support
In-Reply-To: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1358243670-11935-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Lior Amsalem <alior@marvell.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
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
