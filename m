From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Jun 2017 10:13:06 +0200
Subject: [GIT PULL 4/4] arm64: tegra: Device tree changes for v4.13-rc1
In-Reply-To: <20170616081306.11505-1-thierry.reding@gmail.com>
References: <20170616081306.11505-1-thierry.reding@gmail.com>
Message-ID: <20170616081306.11505-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.13-arm64-dt

for you to fetch changes up to 475d99fc216f4b2aed7021734838c9b578338598:

  arm64: dts: nvidia: fix PCI bus dtc warnings (2017-06-13 16:50:48 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.13-rc1

This adds the CCPLEX cluster on Tegra186, which is used to initiate CPU
frequency and voltage transitions.

Also included is a bit of cleanup for PCI related device tree content,
in preparation for a future DTC release that has additional checks for
the PCI bus.

----------------------------------------------------------------
Mikko Perttunen (1):
      arm64: tegra: Add CCPLEX_CLUSTER area in Tegra186

Rob Herring (1):
      arm64: dts: nvidia: fix PCI bus dtc warnings

 arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 7 +++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 4 +++-
 4 files changed, 14 insertions(+), 3 deletions(-)
