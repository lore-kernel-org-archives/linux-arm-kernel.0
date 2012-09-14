From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 14:06:12 -0600
Subject: [GIT PULL 01/10] ARM: tegra: fixes for 3.7
Message-ID: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a number of minor bug-fixes for Tegra.

This branch is based on v3.6-rc4.

----------------------------------------------------------------

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-fixes

for you to fetch changes up to 4b1082ca8cd3bec99fc0ce020a8ba1fa3aa8e22a:

  ARM: enable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA

----------------------------------------------------------------

Peter De Schrijver (2):
      ARM: tegra: fix return value for debugfs init
      ARM: tegra: fix debugfs entry for Tegra30

Stephen Warren (1):
      ARM: enable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA

 arch/arm/Kconfig                |    2 +-
 arch/arm/mach-tegra/powergate.c |   43 ++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 8 deletions(-)
