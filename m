From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 May 2013 21:53:52 +0200
Subject: Allwinner sunXi Fixes for 3.10
Message-ID: <20130524195352.GA19644@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull this small pull request with the sunxi fixes for 3.10

Thanks!
Maxime

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://github.com/mripard/linux.git sunxi/fixes-for-3.10

for you to fetch changes up to 19a280a61b520febab0f2fde94f4bd50250377b2:

  ARM: sunxi: select ARCH_REQUIRE_GPIOLIB (2013-05-15 09:42:47 +0200)

----------------------------------------------------------------
Small set of fixes for 3.10:
  - Fix build breakage in pinctrl driver when no other architecture is selected
  - Fix Mini X-plus device tree build

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: sunxi: Fix Mini X-plus device tree build
      ARM: sunxi: select ARCH_REQUIRE_GPIOLIB

 arch/arm/boot/dts/Makefile                 | 4 +++-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts | 4 ++--
 arch/arm/mach-sunxi/Kconfig                | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
