From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 14:06:20 -0600
Subject: [GIT PULL 09/10] ARM: tegra: defconfig updates
In-Reply-To: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347653181-19936-9-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch updates tegra_defconfig mainly to enable new features that
were either implemented in this kernel release, previously missing, or
recently determined to be useful.

The config entries for explicit board support are now removed, since
Tegra now only supports booting from device tree.

This branch is based on v3.6-rc4.

----------------------------------------------------------------

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-defconfig

for you to fetch changes up to 9df25ccc937525206906c2b546998e5e3062c59b:

  ARM: tegra: defconfig updates

----------------------------------------------------------------

Stephen Warren (1):
      ARM: tegra: defconfig updates

 arch/arm/configs/tegra_defconfig |   51 +++++++++++++++++++++++++++------
 1 files changed, 42 insertions(+), 9 deletions(-)
