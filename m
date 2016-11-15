From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Nov 2016 13:22:23 -0800
Subject: [GIT PULL 5/5] omap defconfig changes for v4.10
In-Reply-To: <pull-1479236877-351747>
References: <pull-1479236877-351747>
Message-ID: <pull-1479236877-351747-5>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/defconfig-signed

for you to fetch changes up to 9c106e4efab2ec96daebb7bdd0bb61602fd52e7a:

  ARM: omap2plus_defconfig: Run make savedefconfig to save some space (2016-11-15 11:01:24 -0800)

----------------------------------------------------------------
Defconfig changes for omaps for v4.10 merge window:

- Enable tsc2004 touchscreen as a loadable module

- Enable REGULATOR_GPIO, dra71-evm needs this for MMC voltage

- Enable LP873x PMICs for dra71x-evm

- Run make savedefconfig to save some space and make it
  easier to generate minimal patches against it

----------------------------------------------------------------
Adam Ford (1):
      ARM: omap2plus_defconfig: Enable TOUCHSCREEN_TSC2004

Lokesh Vutla (2):
      ARM: omap2plus_defconfig: Enable REGULATOR_GPIO
      ARM: omap2plus_defconfig: Enable LP873X support

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Run make savedefconfig to save some space

 arch/arm/configs/omap2plus_defconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
