From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Oct 2017 13:56:01 +0200
Subject: [GIT PULL 5/7] ARM: tegra: Device tree changes for v4.15-rc1
In-Reply-To: <20171020115603.9828-1-thierry.reding@gmail.com>
References: <20171020115603.9828-1-thierry.reding@gmail.com>
Message-ID: <20171020115603.9828-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.15-arm-dt

for you to fetch changes up to 33dfb1e18d534c4b7509de2a68ef1baf83d9710f:

  ARM: tegra: Enable CEC support on Jetson TK1 (2017-10-19 11:45:14 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.15-rc1

Adds support for the CEC controller found on Tegra124 and enables it on
Tegra K1.

----------------------------------------------------------------
Hans Verkuil (2):
      ARM: tegra: Add CEC support for Tegra124
      ARM: tegra: Enable CEC support on Jetson TK1

 arch/arm/boot/dts/tegra124-jetson-tk1.dts |  4 ++++
 arch/arm/boot/dts/tegra124.dtsi           | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)
