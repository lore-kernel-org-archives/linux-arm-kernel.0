From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  5 Dec 2012 14:33:13 +0100
Subject: [GIT PULL] Improve the SMP support of the interrupt controller for
 Armada XP
Message-ID: <1354714394-11622-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

here it is the patch set to improve the Armada XP SMP support. This
pull can be merged without any conflict even on the last
arm-soc/for-next. As Linus Torvalds told that the release of 3.7 won't
happen before next week, I'd like to have this improvement as part of
3.8.

Thanks!

Gregory

The following changes since commit 56580bb422e5f542da19c057f348dd39634138e7:

  Merge branch 'mvebu-misc-fixes' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything (2012-11-24 04:08:49 +0000)

are available in the git repository at:


  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/mvebu-irq-smp-armada-xp

for you to fetch changes up to d1c1c368df413d78f6b9588038eebc13c9a59382:

  arm: mvebu: Improve the SMP support of the interrupt controller (2012-12-05 13:19:26 +0100)

----------------------------------------------------------------
Improve the SMP support of the interrupt controller

This patch allows a better handling of IRQ in SMP mode for the Armada

----------------------------------------------------------------
Yehuda Yitschak (1):
      arm: mvebu: Improve the SMP support of the interrupt controller

 arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c |   49 ++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 5 deletions(-)
