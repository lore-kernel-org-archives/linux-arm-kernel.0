From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Mar 2013 11:16:50 +0100
Subject: [GIT PULL] at91: fixes for 3.9-rc #2
Message-ID: <51517592.5010300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Another "fixes" pull-request for AT91 on top of material that you have already
taken. Fixes are manly typos but the bad node declaration and some misspelling
can cause confusion.

The following changes since commit 0ed66befaae893e82c9f016238282d73ef9fd6c7:

  ARM: at91: fix infinite loop in at91_irq_suspend/resume (2013-03-14 09:37:55 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 9476a186078f47bdc5f03560074691de98cd767b:

  ARM: at91: Fix typo in restart code panic message (2013-03-26 11:00:02 +0100)

----------------------------------------------------------------
Little fixes mainly related to at91sam9x5 DT.
One typo is the only modification in C code.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: at91: Fix typo in restart code panic message

Nicolas Ferre (4):
      ARM: at91/dt: fix macb node declaration
      ARM: at91/trivial: typos in compatible property
      ARM: at91/trivial: fix model name for SAM9G15-EK
      ARM: at91: remove partial parameter in bootargs for at91sam9x5ek.dtsi

 arch/arm/boot/dts/at91sam9g15.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9g15ek.dts |  2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9g35.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9g35ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9x25.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9x25ek.dts | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9x35.dtsi  |  2 +-
 arch/arm/boot/dts/at91sam9x35ek.dts |  9 +++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi |  7 +------
 arch/arm/mach-at91/setup.c          |  2 +-
 12 files changed, 49 insertions(+), 13 deletions(-)

-- 
Nicolas Ferre
