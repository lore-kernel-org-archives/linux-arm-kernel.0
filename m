From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 13:07:56 -0600
Subject: [GIT PULL 1/6] ARM: tegra: dependencies for ARM .init_time cleanup
Message-ID: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a dependency for Sebastian Hesselbarth's series that
cleans up the ARM machine descriptor's .init_time hook. It may also end
up being a dependency for cleanup/development in the Tegra tree, and
hence is contained in its own topic branch, to allow conflicts to be
easily resolved.

----------------------------------------------------------------

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.13-deps-for-arm-init-time-cleanup

for you to fetch changes up to d2207071b3c74b144a860cbe6a46496a44963972:

  ARM: tegra: split tegra_pmc_init() in two

----------------------------------------------------------------

Stephen Warren (1):
      ARM: tegra: split tegra_pmc_init() in two

 arch/arm/mach-tegra/common.c |  4 +---
 arch/arm/mach-tegra/pmc.c    | 41 +++++++++++++++++++++------------------
 arch/arm/mach-tegra/pmc.h    |  1 +
 arch/arm/mach-tegra/tegra.c  | 12 +++++++++++-
 4 files changed, 35 insertions(+), 23 deletions(-)
