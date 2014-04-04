From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Apr 2014 17:42:03 +0200
Subject: [PATCH 0/2] ARM: mvebu: enable SDHCI interface on Armada 38x
Message-ID: <1396626125-8631-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Gregory, Andrew, Sebastian,

Here is a small set of two patches that enable the SDHCI interface on
Armada 38x. The first one adds the DT details, the second one adjusts
the appropriate defconfigs to include the relevant driver.

The sdhci-pxav3 driver change has been taken by the MMC maintainer
Chris Ball, and is already in linux-next, so I presume it will be part
of 3.15. Regarding those proposed patches, they are obviously aimed at
3.16.

These patches are based on linux-next, but I can resend them if needed
once 3.15-rc1 is released.

Thanks!

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: enable the SDHCI interface on Armada 385
  ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the relevant defconfigs

 arch/arm/boot/dts/armada-385-db.dts | 8 ++++++++
 arch/arm/boot/dts/armada-38x.dtsi   | 9 +++++++++
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 4 files changed, 19 insertions(+)

-- 
1.8.3.2
