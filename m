From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 12:36:48 +0200
Subject: [GIT PULL] Ux500 devicetree changes for v3.17
Message-ID: <CACRpkda=5smrLuzHpAy_RxuEqcH9C=u3-sKmRgVxnEX4ko5bSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

here are some three Ux500 device tree patches that I'd like
to have funneled upstream for v3.17. Sorry for the bad tag
name.

The dependent changes to drivers and bindings are merged
through subsystem trees.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:

  Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-devicetree-v3.16-1

for you to fetch changes up to d0e3bc813359360fb94098fec9403820846577f3:

  ARM: ux500: add misc sensors to the device trees (2014-07-07 11:54:07 +0200)

----------------------------------------------------------------
Ux500 device tree patches for v3.17:
- Add regulators to STMPE expanders
- Add proper DMA channels for all SD/MMC blocks
- Add sensors to the device tree

----------------------------------------------------------------
Linus Walleij (3):
      ARM: ux500: add VCC and VIO regulators to STMPE IC
      ARM: ux500: add some DB8500 DMA channel info
      ARM: ux500: add misc sensors to the device trees

 arch/arm/boot/dts/ste-dbx5x0.dtsi          | 10 +++++
 arch/arm/boot/dts/ste-href-stuib.dtsi      |  2 +
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 59 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi     | 24 ------------
 arch/arm/boot/dts/ste-snowball.dts         | 38 +++++++++++++++++--
 5 files changed, 106 insertions(+), 27 deletions(-)
