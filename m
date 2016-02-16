From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 19:15:02 +0100
Subject: [PATCH v4 12/12] arm64: defconfig: enable Armada 3700 related config
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1455646502-23834-13-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the configuration for the Armada 3700 family and for
the related driver it uses.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 18ca9fb9e65f..7ca2f0247ec5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS7=y
@@ -93,6 +94,7 @@ CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_CEVA=y
+CONFIG_AHCI_MVEBU=y
 CONFIG_AHCI_XGENE=y
 CONFIG_SATA_RCAR=y
 CONFIG_PATA_PLATFORM=y
@@ -132,6 +134,7 @@ CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
+CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
@@ -162,6 +165,8 @@ CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_SND_SOC_AK4613=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.5.0
