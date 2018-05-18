From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 May 2018 16:22:44 +0200
Subject: [GIT PULL 4/5] ARM: tegra: Device tree changes for v4.18-rc1
In-Reply-To: <20180518142245.20242-1-thierry.reding@gmail.com>
References: <20180518142245.20242-1-thierry.reding@gmail.com>
Message-ID: <20180518142245.20242-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.18-arm-dt

for you to fetch changes up to dc4ea601be724d7ad37c8c5b1059417126e97e27:

  ARM: dts: tegra114: Add IOMMU nodes to Host1x and its clients (2018-05-04 17:21:02 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.18-rc1

Contains a fix for the high-speed UART on Toradex Apalis TK1 boards as
well as IOMMU enablement for various devices on Tegra30 and Tegra30.

----------------------------------------------------------------
Dmitry Osipenko (2):
      ARM: dts: tegra30: Add IOMMU nodes to Host1x and its clients
      ARM: dts: tegra114: Add IOMMU nodes to Host1x and its clients

Marcel Ziswiler (1):
      ARM: tegra: apalis-tk1: Fix high speed UART compatible

 arch/arm/boot/dts/tegra114.dtsi             |  5 +++++
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi |  6 +++---
 arch/arm/boot/dts/tegra124-apalis.dtsi      |  6 +++---
 arch/arm/boot/dts/tegra30.dtsi              | 14 ++++++++++++++
 4 files changed, 25 insertions(+), 6 deletions(-)
