From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 11 May 2015 11:49:24 +0200
Subject: [GIT PULL] at91: dt for 4.2 #1
Message-ID: <1431337764-21824-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

First DT batch for AT91 dedicated to enhancement coming from Overkiz. More to
come for 4.2 obviously but I wanted to send this batch as it is ready.

Thanks, best regards,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt

for you to fetch changes up to 7107bb0b2836f0f9b1ffed1f5189e269ee25e5b9:

  ARM: at91/dt: drop deprecated mainck node from pmc (2015-05-11 11:24:01 +0200)

----------------------------------------------------------------
First batch of DT changes for 4.2:
- cleanup and addition of Overkiz boards
- at91sam9x5: pwm0 pinctrl definition
- delete deprecated mainck nodes

----------------------------------------------------------------
Ga?l PORTAY (11):
      ARM: at91/dt: kizbox: rename to at91-kizbox
      ARM: at91/dt: at91-kizbox: sanitize file
      ARM: at91/dt: at91-kizbox: user proper serial uart
      ARM: at91/dt: at91-kizbox: gpio-keys related changes
      ARM: at91/dt: at91-kizbox: leds related changes
      ARM: at91/dt: at91-kizbox: re-size nand partitions
      ARM: at91/dt: at91-kizbox: update chosen node
      ARM: at91/dt: sam9x5: add pinctrl for pwm0
      ARM: at91/dt: add support for kizboxmini
      ARM: at91/dt: add support for kizbox2
      ARM: at91/dt: drop deprecated mainck node from pmc

 arch/arm/boot/dts/Makefile                  |   4 +-
 arch/arm/boot/dts/at91-kizbox.dts           | 159 ++++++++++++++++++++
 arch/arm/boot/dts/at91-kizbox2.dts          | 216 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91-kizboxmini.dts       | 129 +++++++++++++++++
 arch/arm/boot/dts/at91-sama5d3_xplained.dts |   6 -
 arch/arm/boot/dts/at91sam9rlek.dts          |   6 -
 arch/arm/boot/dts/at91sam9x5.dtsi           |  46 ++++++
 arch/arm/boot/dts/kizbox.dts                | 150 -------------------
 arch/arm/boot/dts/sama5d3xcm.dtsi           |   6 -
 9 files changed, 553 insertions(+), 169 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kizbox.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini.dts
 delete mode 100644 arch/arm/boot/dts/kizbox.dts

-- 
Nicolas Ferre
