From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 08 Mar 2011 11:01:37 +0200
Subject: [GIT PULL]: TrimSlice update
Message-ID: <4D75F071.7050401@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

Please pull last minute update for the TrimSlice that enables the SD
slots on the platform.

The patches are based on your current for-next branch.

The following changes since commit d5fdafd38ca0c28c4648909ce0afd0a5420309ca:

  ARM: tegra: trimslice: initialize PCI-e only when running on TrimSlice
(2011-03-03 13:57:31 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux-tegra.git
trimslice/upstream

Mike Rapoport (1):
      ARM: tegra: trimslice: enable MMC/SD slots

 arch/arm/mach-tegra/board-trimslice-pinmux.c |    9 +++++++++
 arch/arm/mach-tegra/board-trimslice.c        |   19 +++++++++++++++++++
 arch/arm/mach-tegra/board-trimslice.h        |    3 +++
 3 files changed, 31 insertions(+), 0 deletions(-)


-- 
Sincerely yours,
Mike.
