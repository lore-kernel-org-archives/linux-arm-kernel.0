From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Mon, 11 Jul 2016 21:08:11 +0300
Subject: [PATCH RESEND 1/2] ARM: multi_v7_defconfig: Enable AHCI_IMX
Message-ID: <20160711180812.10610-1-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wandboard Quad comes with a SATA port. Enable the IMX SATA driver by
default to make it easy to have the root filesystem on it.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
Resent for the i.MX maintainers to apply.

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 26c35f8..0b20712 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -220,6 +220,7 @@ CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_BRCM=y
 CONFIG_AHCI_ST=y
+CONFIG_AHCI_IMX=y
 CONFIG_AHCI_SUNXI=y
 CONFIG_AHCI_TEGRA=y
 CONFIG_SATA_HIGHBANK=y
-- 
2.9.0
