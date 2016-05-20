From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 May 2016 12:07:28 -0700
Subject: [PATCH 3/7] ARM: multi_v7_defconfig: Enable BRCMSTB AHCI
In-Reply-To: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
References: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1463771252-12805-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Broadcom STB AHCI driver and its companion PHY driver to get
functional SATA3 support.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 31ed7318f406..07ad8f9a033b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -217,6 +217,7 @@ CONFIG_SCSI_MULTI_LUN=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_BRCMSTB=y
 CONFIG_AHCI_ST=y
 CONFIG_AHCI_SUNXI=y
 CONFIG_AHCI_TEGRA=y
@@ -830,6 +831,7 @@ CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_PHY_BRCMSTB_SATA=y
 CONFIG_NVMEM=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_BCM2835_MBOX=y
-- 
2.7.4
