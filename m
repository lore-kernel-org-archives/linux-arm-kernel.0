From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 May 2016 09:38:50 +0200
Subject: [GIT PULL] Device Tree updated for Ux500 for v4.7
Message-ID: <CACRpkdbjdM=L4DEUZ5fuDPRumXdiztqht1h+zu+UZoJKk1dXoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

I guess I should have gotten this out the door earlier, especially
since the patches were around since forever.

Anyways this is a few cleanups of DTS files (use proper includes)
and the assignment of the accelerometers as open drain so they
actually work.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-armsoc-v4.7

for you to fetch changes up to 7ba5dd530072d383f713a0fe1e4ffcdc5523ae37:

  ARM: dts: ux500: configure the accelerometers open drain (2016-05-04
09:33:25 +0200)

----------------------------------------------------------------
Devicetree updates for v4.7:
- Use generic include files
- Make accelerometers open drain on the TVK board

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: ux500: use the GPIO DT header
      ARM: dts: ux500: use the GIC include header
      ARM: dts: ux500: configure the accelerometers open drain

 arch/arm/boot/dts/ste-ccu9540.dts          |  2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi          | 92 +++++++++++++++---------------
 arch/arm/boot/dts/ste-href-stuib.dtsi      |  4 +-
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 16 +++---
 arch/arm/boot/dts/ste-hrefprev60.dtsi      |  8 +--
 arch/arm/boot/dts/ste-hrefv60plus.dtsi     |  6 +-
 arch/arm/boot/dts/ste-snowball.dts         | 19 +++---
 7 files changed, 75 insertions(+), 72 deletions(-)
