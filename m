From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 21 Oct 2013 22:37:12 -0700
Subject: [GIT PULL] bcm dt updates for 3.13
Message-ID: <CAEPRUYro7a_o0EMachJY5GWJRv7By_u+0r5D9s2aKBRw++DCXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git tags/bcm-for-3.13-dt

for you to fetch changes up to 484391ac1e3c95fb3bd753d6fb0d57b845a9a428:

  ARM: dts: bcm11351: Use GIC/IRQ defines for sdio interrupts
(2013-10-02 23:01:44 -0700)

----------------------------------------------------------------
Changes for 3.13/dt
- Add gpio+uart+sd irq configuration to bcm281xx DT
- Miscelaneous cleanups.

----------------------------------------------------------------
Christian Daudt (1):
      rename ARCH_BCM to ARCH_BCM_MOBILE (dt)

Markus Mayer (2):
      ARM: bcm281xx: Add device node for the GPIO controller
      ARM: dts: bcm281xx: Add card detect GPIO

Matt Porter (1):
      ARM: dts: bcm11351: Use GIC/IRQ defines for sdio interrupts

Tim Kryger (1):
      ARM: DT: Add missing UARTs for bcm11351 (bcm281xx)
 arch/arm/boot/dts/Makefile         |  4 +--
 arch/arm/boot/dts/bcm11351-brt.dts |  1 +
 arch/arm/boot/dts/bcm11351.dtsi    | 54 +++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/bcm28155-ap.dts  |  1 +
 4 files changed, 54 insertions(+), 6 deletions(-)
