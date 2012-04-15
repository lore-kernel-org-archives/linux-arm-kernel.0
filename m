From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 15 Apr 2012 23:20:55 +0200
Subject: [git pull] Renesas DT changes for v3.5
Message-ID: <201204152320.56147.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

    Linux 3.4-rc2

with top-most commit 3b7b70552afe351a8bd8fff1eb2d60aab2206576:

    ARM: mach-shmobile: sh7372 generic board support via DT V2

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git dt

to receive material requisite for preliminary support of device trees on
Renesas platforms.

Thanks!


 arch/arm/boot/dts/sh7372.dtsi                |   21 +++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 arch/arm/mach-shmobile/include/mach/intc.h   |   44 +++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/irqs.h   |    2 +-
 arch/arm/mach-shmobile/intc-sh7372.c         |   34 ++++++++++++------
 arch/arm/mach-shmobile/setup-sh7372.c        |   48 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/timer.c               |   17 +++++++++
 7 files changed, 155 insertions(+), 13 deletions(-)

---------------

Magnus Damm (6):
      ARM: mach-shmobile: Introduce shmobile_setup_delay()
      ARM: mach-shmobile: Introduce INTC_IRQ_PINS_16H
      ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
      ARM: mach-shmobile: Use INTC_IRQ_PINS_16H on sh7372
      ARM: mach-shmobile: Rework sh7372 INTCS demuxer V2
      ARM: mach-shmobile: sh7372 generic board support via DT V2
