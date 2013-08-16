From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 11:20:25 -0600
Subject: [GIT PULL 1/4] ARM: tegra: cleanups for 3.12
Message-ID: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes a single cleanup patch which removes redundant
error-handling for platform_get_resource().

----------------------------------------------------------------

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.12-cleanup

for you to fetch changes up to 946a88df76a2c5a9f4087fb41efd9d2763872302:

  tegra: simplify use of devm_ioremap_resource

----------------------------------------------------------------

Julia Lawall (1):
      tegra: simplify use of devm_ioremap_resource

 drivers/iommu/tegra-smmu.c  | 2 --
 drivers/memory/tegra20-mc.c | 2 --
 drivers/memory/tegra30-mc.c | 2 --
 3 files changed, 6 deletions(-)
