From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 5 Sep 2012 15:08:29 +0800
Subject: [GIT PULL] CSR SiRFprimaII dt-binding pinmux mapping
Message-ID: <CAGsJ_4z-A1JXwrHwFpggdwo5Ku64fdNH-z=cMSDNRdf8YzEF9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,
Please pull the following patches which are making prima2 pinctrl
driver support dt-binding mapping.
All have been acked by Linus and we think it is better to take them by arm soc.

Thanks
barry

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:
  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git pinmux-dt

Barry Song (3):
      ARM: PRIMA2: add missing interrupts property for pinctrl node
      ARM: PRIMA2: rename prima2-cb.dts to prima2.dtsi as it only has
SoC features
      pinctrl: sirf: add DT-binding pinmux mapping support

 arch/arm/boot/dts/prima2-cb.dts    |  424 ------------------------
 arch/arm/boot/dts/prima2-evb.dts   |   37 ++
 arch/arm/boot/dts/prima2.dtsi      |  640 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/Makefile.boot |    2 +
 drivers/pinctrl/pinctrl-sirf.c     |   58 ++++-
 5 files changed, 736 insertions(+), 425 deletions(-)
 delete mode 100644 arch/arm/boot/dts/prima2-cb.dts
 create mode 100644 arch/arm/boot/dts/prima2-evb.dts
 create mode 100644 arch/arm/boot/dts/prima2.dtsi
