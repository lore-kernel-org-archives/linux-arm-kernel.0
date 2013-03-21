From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 21 Mar 2013 19:17:39 +0530
Subject: [PATCH V2 0/4] ARM: tegra: dalmore: add regulators
Message-ID: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add the regulators for Dalmore platform.
Dalmore also have the Palma PMIC as primary PMIC but 
dt population will be send later once DT documentation
finalize.

Changes from V1:
- Rearrange patches so that config change will be last patch.
- Correct some sentence and Caps.
- fix compilation issue arise in mid of patches.

Laxman Dewangan (4):
  ARM: tegra: dalmore: add cpu regulator node
  ARM: tegra: dalmore: add TPS65090 node
  ARM: tegra: dalmore: add fixed regulator node
  ARM: tegra: enable Tegra114 based platform PMICs

 arch/arm/boot/dts/tegra114-dalmore.dts |  162 ++++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig       |    7 ++
 2 files changed, 169 insertions(+), 0 deletions(-)
