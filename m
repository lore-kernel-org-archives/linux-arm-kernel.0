From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 14:15:51 -0600
Subject: [GIT PULL] ARM: create a cros-ec-keyboard DT fragment
Message-ID: <1402949751-930-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a series from Doug Anderson that creates a DT
include file to share some common DT content between Tegra and Exynos
boards that use cros-ec. I'll be pulling this into Tegra's for-3.17/dt
branch, and I assume the Samsung maintainers will do something similar.

----------------------------------------------------------------

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.17-dt-cros-ec-kbd

for you to fetch changes up to 1a395e3b4f2e9038964c9eec392ed5300a4b5b83:

  ARM: dts: Use the cros-ec-keyboard fragment in exynos5250-snow

----------------------------------------------------------------

Doug Anderson (3):
      ARM: dts: Create a cros-ec-keyboard fragment
      ARM: tegra: Use the cros-ec-keyboard fragment in venice2
      ARM: dts: Use the cros-ec-keyboard fragment in exynos5250-snow

 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 105 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts   |  93 +-----------------------
 arch/arm/boot/dts/tegra124-venice2.dts  |  96 +-----------------------
 3 files changed, 111 insertions(+), 183 deletions(-)
 create mode 100644 arch/arm/boot/dts/cros-ec-keyboard.dtsi
