From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Oct 2014 09:38:17 +0200
Subject: [GIT PULL] RealView device tree support
Message-ID: <CACRpkdbVtkme_CYrmF7ymsMGP3OO9mr_DPALRUeWGQh35-Uf=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bit late maybe, so no biggie if this does not hit the merge
window.

However the dependent driver changes are already pending,
and this is pretty isolated. Now the device tree support is
split in two patches as requested.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-dt-v3.18

for you to fetch changes up to 63fc5a393cde11dfa3f5c04539f5d0c6a4fc4229:

  ARM: realview: add device tree and bindings for PB1176 (2014-10-01
09:32:42 +0200)

----------------------------------------------------------------
This implements ARM RealView device tree support.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: realview: basic device tree implementation
      ARM: realview: add device tree and bindings for PB1176

 Documentation/devicetree/bindings/arm/arm-boards |  65 ++++++
 Documentation/devicetree/bindings/arm/gic.txt    |   1 +
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts        | 247 +++++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                   |  13 ++
 arch/arm/mach-realview/Makefile                  |   1 +
 arch/arm/mach-realview/realview-dt.c             |  32 +++
 drivers/irqchip/irq-gic.c                        |   2 +
 8 files changed, 362 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
 create mode 100644 arch/arm/mach-realview/realview-dt.c
