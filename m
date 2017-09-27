From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Sep 2017 23:27:32 +0200
Subject: [GIT PULL] Delete old PCIv3 driver
Message-ID: <CACRpkdY9KSaHNyhrWC2te84eiFMfdUC0j7SGxo6MJ5JZpPorAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

the new PCIv3 driver is merged and ready in the PCI tree so please pull in
this patch deleting the old driver in mach-integrator.

Yours,
Linus Walleij


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-pciv3-delete

for you to fetch changes up to 70f8e9cc2362bbbd9ba482dcfa2245bd18c700ba:

  ARM: integrator: Delete the V3 PCI driver (2017-09-27 23:20:22 +0200)

----------------------------------------------------------------
This deletes the old PCIv3 driver in the Integrator machine.
It has been superceded by a modernized driver in the PCI
subsystem host/ directory.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: integrator: Delete the V3 PCI driver

 arch/arm/mach-integrator/Makefile        |   2 -
 arch/arm/mach-integrator/integrator_ap.c |   2 -
 arch/arm/mach-integrator/pci_v3.c        | 900 -------------------------------
 arch/arm/mach-integrator/pci_v3.h        |   9 -
 4 files changed, 913 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/pci_v3.c
 delete mode 100644 arch/arm/mach-integrator/pci_v3.h
