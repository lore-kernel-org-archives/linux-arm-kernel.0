From: mike@compulab.co.il (Mike Rapoport)
Date: Wed,  2 Mar 2011 14:34:03 +0200
Subject: [PATCH 0/3] ARM: tegra: PCI-e improvements 
Message-ID: <cover.1299068166.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
This patches add PCI-e powergating support and fix for TrimSlice PCI-e initialization in the mutliplatform kernels.

The patches are also available at git repository 
  git://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux-tegra.git trimslice/upstream

The following changes since commit ccac05152e7c6a8103b9e7a801bc995180a800fc:

  ARM: Tegra: DMA: Fail safe if initialization fails (2011-02-23 14:06:03 -0800)

Mike Rapoport (3):
  ARM: tegra: PCIE minor code refactoring
  ARM: tegra: add PCI Express power gating
  ARM: tegra: trimslice: initialize PCI-e only when running on
    TrimSlice

 arch/arm/mach-tegra/board-trimslice.c |    3 ++
 arch/arm/mach-tegra/pcie.c            |   38 ++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 10 deletions(-)

-- 
1.7.3.1
