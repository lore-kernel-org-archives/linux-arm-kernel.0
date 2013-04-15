From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Apr 2013 18:01:02 +0200
Subject: [GIT PULL] sunXi dt additions, take 4
Message-ID: <516C243E.2050407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This pull request for 3.10 is just one small patch changing slightly
merging the fixed rate oscillator with the oscillator gates.

This one will be the last pull request for 3.10-rc1.

Thanks,
Maxime

The following changes since commit 0b19b7c2c6e169efccb4b1632fe628969d001618:

  ARM: sunxi: dt: Update watchdog compatible string (2013-04-08 21:56:34 +0200)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-dt-for-3.10-4

for you to fetch changes up to 92fd6e066a4ecdf161710afe6460bc372899ae5f:

  ARM: sunxi: unify osc24M_fixed and osc24M (2013-04-15 10:24:54 +0200)

----------------------------------------------------------------
Fourth round of dt additions for 3.10

There's only one late patch that merge together two clocks that were
already defined in a previous patch.

----------------------------------------------------------------
Emilio L?pez (1):
      ARM: sunxi: unify osc24M_fixed and osc24M

 arch/arm/boot/dts/sun4i-a10.dtsi |    8 +-------
 arch/arm/boot/dts/sun5i-a13.dtsi |    8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
