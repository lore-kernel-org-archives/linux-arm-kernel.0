From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 18:21:09 +0200
Subject: [GIT PULL] ARM: tegra: Default configuration updates for v4.7-rc1
Message-ID: <1461946869-26124-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC maintainers,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-defconfig

for you to fetch changes up to fe42f031765e2cfaf5363b52664a634a4fe19c1a:

  ARM: multi_v7: Enable Tegra XUSB controller in defconfig (2016-04-29 18:13:52 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Default configuration updates for v4.7-rc1

Enable the XUSB pad controller and XUSB controller drivers on the Tegra
and multi-v7 default configurations.

----------------------------------------------------------------
Thierry Reding (2):
      ARM: tegra: Enable XUSB controller in defconfig
      ARM: multi_v7: Enable Tegra XUSB controller in defconfig

 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/tegra_defconfig    | 2 ++
 2 files changed, 4 insertions(+)
