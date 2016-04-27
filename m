From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Apr 2016 17:41:57 +0200
Subject: [GIT PULL] at91: dt for 4.7 #2
Message-ID: <1461771717-32284-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

I collected some more DT patches. The fixes are low priority, this is why I
added them in this DT pull-request.
The shutdown controller is new and will appear in mainline during the 4.7 merge
window.

Thanks, best regards,

The following changes since commit fd718627b31dfccc1875320a1e63bfc654ca4dc4:

  ARM: dts: at91: sama5d2: add LCD controller (2016-03-29 16:32:33 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt2

for you to fetch changes up to 517550075c31917dc729d7cec0b4a0ca65294f14:

  ARM: dts: at91: sama5d2: add slow clock to watchdog node (2016-04-27 14:08:58 +0200)

----------------------------------------------------------------
Second batch of DT changes for 4.7:
- three low priority fixes:
  - sama5d2: one pin definition and dependency with the slow clock for watchdog
  - sama5d4: definition of watchdog IRQ property
- addition of the new shutdown controller to sama5d2 & sama5d2 Xplained

----------------------------------------------------------------
Florian Vallee (1):
      ARM: dts: at91: fix typo in sama5d2 PIN_PD24 description

Nicolas Ferre (3):
      ARM: dts: at91: sama5d4: add watchdog interrupt property
      ARM: dts: at91: sama5d2: add shutdown controller node
      ARM: dts: at91: sama5d2: add slow clock to watchdog node

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  9 +++++++++
 arch/arm/boot/dts/sama5d2-pinfunc.h         |  4 ++--
 arch/arm/boot/dts/sama5d2.dtsi              | 10 ++++++++++
 arch/arm/boot/dts/sama5d4.dtsi              |  1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre
