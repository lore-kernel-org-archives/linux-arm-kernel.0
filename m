From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 17 Apr 2012 11:40:00 +0530
Subject: [PATCH V1 0/2] ARM: dt: add ALS and proximity sensor ISL29028
Message-ID: <1334643002-6337-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the entry of ISL29028 in dts file of tegra_cardhu and the tegra
defconfig file for building it.

Laxman Dewangan (2):
  ARM: dt: tegra_cardhu: als and proximity sensor isl29028 support
  ARM: config: tegra: add ISL29028

 arch/arm/boot/dts/tegra-cardhu.dts |    6 ++++++
 arch/arm/configs/tegra_defconfig   |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)
