From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 12:17:02 -0600
Subject: [GIT PULL] ARM: tegra: fixes branch
Message-ID: <4FA9631E.3040500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of small fixes, independent from anything else:

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:
  Linus Torvalds (1):
        Linux 3.4-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.5/fixes

Stephen Warren (2):
      ARM: tegra: add pll_x freq table entry for 750MHz
      ARM: disable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA

 arch/arm/Kconfig                    |    2 +-
 arch/arm/mach-tegra/tegra2_clocks.c |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)
