From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 14:03:09 -0700
Subject: [GIT PULL] omap fixes against v4.1-rc4
Message-ID: <20150520210309.GA18439@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e60a8fe1792dcd3aacda0959e0f4865bfefb7bb5:

  Merge tag 'for-v4.1-rc/omap-fixes-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.1/fixes (2015-05-11 13:23:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-rc4

for you to fetch changes up to f25bf74c8862efdc30453d16d60cf22958a4873e:

  ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK (2015-05-20 10:00:10 -0700)

----------------------------------------------------------------
Few minimal omap device tree fixes for v4.1-rc series:

- Disable BeagleBone black RTC-only sleep mode because of hardare
  related issues

- Fix NAND on Devkit8000

- Fix WLAN interrupt line on AM335x EVM-SK

----------------------------------------------------------------
Anthoine Bourgeois (1):
      ARM: dts: omap3-devkit8000: Fix NAND DT node

Robert Nelson (1):
      ARM: dts: am335x-boneblack: disable RTC-only sleep

Romain Izard (1):
      ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK

 arch/arm/boot/dts/am335x-boneblack.dts | 4 ----
 arch/arm/boot/dts/am335x-evmsk.dts     | 2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts | 2 ++
 3 files changed, 3 insertions(+), 5 deletions(-)
