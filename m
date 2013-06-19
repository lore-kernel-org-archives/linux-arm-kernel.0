From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Jun 2013 12:10:45 +0200
Subject: [GIT PULL] Allwinner sunXi platform additions for 3.11, take 2
Message-ID: <20130619101045.GA8067@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please consider pulling this small pull request of machine changes to
support the A10s.

Thanks

The following changes since commit ec3805e6199649db2a462045a38eb1050c6151aa:

  ARM: sunxi: irqchip: Update the documentation (2013-05-29 09:39:39 +0200)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-core-for-3.11-2

for you to fetch changes up to 81265dfb1ccba0941e54a61c2473befe8c09edc0:

  ARM: sunxi: Add Allwinner A10s machine compatible (2013-06-16 20:49:30 +0200)

----------------------------------------------------------------
Allwinner platform additions, take 2

Adds machine support for the Allwinner A10s SoC

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Add Allwinner A10s machine compatible

 Documentation/arm/sunxi/README | 4 ++++
 arch/arm/mach-sunxi/sunxi.c    | 1 +
 2 files changed, 5 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
