From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 16:48:05 +0200
Subject: [GIT PULL 4/5] ARM: tegra: Device tree changes for v4.14-rc1
In-Reply-To: <20170818144806.14252-1-thierry.reding@gmail.com>
References: <20170818144806.14252-1-thierry.reding@gmail.com>
Message-ID: <20170818144806.14252-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.14-arm-dt

for you to fetch changes up to e3ff43b6c991bc8cbfa7e926ef0f655b4bae3fee:

  ARM: tegra: Enable UDC on AC100 (2017-08-17 16:37:06 +0200)

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.14-rc1

One fix for Tegra124 to hook the host1x device up with the SMMU.

The remainder of this enables USB device mode on a couple of boards
where the port is currently unused.

----------------------------------------------------------------
Dmitry Osipenko (1):
      ARM: tegra: Enable UDC on AC100

Paul Kocialkowski (1):
      ARM: tegra: Register host1x node with IOMMU binding on Tegra124

Thierry Reding (3):
      ARM: tegra: Enable UDC on Beaver
      ARM: tegra: Enable UDC on Dalmore
      ARM: tegra: Enable UDC on Jetson TK1

 arch/arm/boot/dts/tegra114-dalmore.dts    | 10 ++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 12 +++++++++++-
 arch/arm/boot/dts/tegra124.dtsi           |  1 +
 arch/arm/boot/dts/tegra20-paz00.dts       |  2 ++
 arch/arm/boot/dts/tegra30-beaver.dts      | 10 ++++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)
