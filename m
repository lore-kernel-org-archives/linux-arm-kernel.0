From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Mar 2012 10:51:42 -0700
Subject: [GIT PULL] A few more non-critical fixes for tegra
Message-ID: <CAOesGMhELxtTnVMzADM01RhsPcGt7ciqLh-h0+xNwUg8MGCo1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

A few more patches have been added to the cleanup-and-fixes branch for
tegra, see below. Please pull on top of current tegra/cleanups
contents!


Thanks,

-Olof


The following changes since commit f6a1ba67362fe78a1ec81c355ee638c70689b5d7:

  ARM: tegra: Enable CPUIdle on Tegra20 (2012-03-04 11:17:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git
for-3.4/cleanup-and-fixes

for you to fetch changes up to 279b658525abd06645938fb607860de42c4cf31e:

  ARM: tegra: select USB_ULPI if USB is selected (2012-03-18 10:34:32 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: tegra: select USB_ULPI if USB is selected

Dmitry Artamonow (3):
      arm/tegra: fix harmony pinmux for PCIe
      arm/tegra: add timeout to PCIe PLL lock detection loop
      arm/tegra: pcie: fix return value of function

 arch/arm/mach-tegra/Kconfig                |    4 ++--
 arch/arm/mach-tegra/board-harmony-pinmux.c |    6 +++---
 arch/arm/mach-tegra/pcie.c                 |   16 ++++++++++++----
 3 files changed, 17 insertions(+), 9 deletions(-)
