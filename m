From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 20 Mar 2013 19:14:26 +0530
Subject: [PATCH 0/4] ARM: tegra: dalmore: add regulators
Message-ID: <1363787070-14801-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add the regulators for Dalmore platform.
Dalmore also have the Palma PMIC as primary PMIC but
dt population will be send later once DT documentation
finalize.

Laxman Dewangan (4):
  ARM: tegra: enable Tegra114 based platform PMICs
  ARM: tegra: dalmore: add cpu regulator's node
  ARM: tegra: dalmore: add dt node for TPS65090's regulators
  ARM: tegra: dalmore: add fixed regulator's node

 .../devicetree/bindings/regulator/tps65090.txt     |    4 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |  160 ++++++++++++++++++++
 arch/arm/configs/tegra_defconfig                   |    7 +
 3 files changed, 169 insertions(+), 2 deletions(-)
