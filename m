From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 12:15:43 -0600
Subject: [GIT PULL] ARM: tegra: cleanup branch
Message-ID: <4FA962CF.1030809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of small cleanups for Tegra, independent from anything else:

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:
  Linus Torvalds (1):
        Linux 3.4-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.5/cleanup

Arnd Bergmann (1):
      ARM: tegra: do not hide dma declarations

Danny Kukawka (1):
      ARM: tegra: fix multiple asm/hardware/gic.h inclusion

 arch/arm/mach-tegra/board-dt-tegra20.c |    1 -
 arch/arm/mach-tegra/include/mach/dma.h |    4 ----
 2 files changed, 0 insertions(+), 5 deletions(-)
