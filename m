From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 13 Mar 2011 18:35:13 +0100
Subject: [PULL] PXA marex/devel-fix
Message-ID: <201103131835.13226.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Eric, can you please ... thanks.

The following changes since commit a4ee3fbac8f3afe99fa91d97f7c9597b3f5b83ea:

  ARM: pxa/colibri: use correct SD detect pin (2011-01-17 08:51:58 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6 devel-fix

Marek Vasut (1):
      ARM: pxa: Properly configure PWM period for palm27x

Vasily Khoruzhick (6):
      ARM: PXA: Z2: Use only power button as wake source
      ARM: PXA: Z2: Fix battery pdata
      ARM: PXA: Z2: Fix libertas init/tear down sequences
      ARM: PXA: Z2: Keep kbd backlight disabled by default
      ARM: PXA: Z2: Add default triggers for LEDs
      ARM: PXA: Z2: Use switch event for lid

 arch/arm/mach-pxa/include/mach/z2.h |    3 +-
 arch/arm/mach-pxa/palm27x.c         |    2 +-
 arch/arm/mach-pxa/z2.c              |   75 +++++++++++++++++------------------
 3 files changed, 39 insertions(+), 41 deletions(-)
