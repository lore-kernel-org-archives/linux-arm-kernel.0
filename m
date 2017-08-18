From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 16:48:06 +0200
Subject: [GIT PULL 5/5] ARM: tegra: Default configuration updates for v4.14-rc1
In-Reply-To: <20170818144806.14252-1-thierry.reding@gmail.com>
References: <20170818144806.14252-1-thierry.reding@gmail.com>
Message-ID: <20170818144806.14252-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.14-arm-defconfig

for you to fetch changes up to f6982786df61513c3614c91d492f3c1b21da6128:

  ARM: defconfig: tegra: Enable ChipIdea UDC driver (2017-08-17 16:29:53 +0200)

----------------------------------------------------------------
ARM: tegra: Default configuration updates for v4.14-rc1

Enables the ChipIdea UDC driver and selects some symbols that were
previously being selected by other drivers but will no longer be in
v4.14.

----------------------------------------------------------------
Dmitry Osipenko (1):
      ARM: defconfig: tegra: Enable ChipIdea UDC driver

Paul Kocialkowski (2):
      ARM: tegra: Add Tegra I2S interfaces to defconfig
      ARM: configs: Add Tegra I2S interfaces to multi_v7_defconfig

Thierry Reding (1):
      ARM: tegra: Update default configuration for v4.13-rc1

 arch/arm/configs/multi_v7_defconfig |  2 ++
 arch/arm/configs/tegra_defconfig    | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)
