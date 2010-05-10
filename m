From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 10 May 2010 22:06:57 +0200
Subject: [PATCH 0/4] ARM: Gemini: board/maintainer updates
Message-ID: <1273522021-14436-1-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello to all,

Here are some board updates for the Gemini SoC

The sources are from the openwrt-team and Janos Laube.
I've removed only parts that are not in Linus' tree, mainly drivers for 
ethernet, usb and other stuff.

The the driver for watchdog and rtc are ready to ship.
These will be added on the next round, avoiding some chicken and egg 
problem ;-)

Patches 1-3 _must_ be applied in order, due Kconfig and Makefile changes.

Ulli

Hans Ulli Kroll (1):
      MAINTAINERS: update for ARM/Gemini

Imre Kaloz (2):
      ARM: Gemini: add support for Wiligear WBD-111
      ARM: Gemini: add support for Wiliboard WBD-222

Janos Laube (1):
      ARM: Gemini: add support for Raidsonic IB4220

 MAINTAINERS                           |   11 ++-
 arch/arm/mach-gemini/Kconfig          |   21 +++++
 arch/arm/mach-gemini/Makefile         |    3 +
 arch/arm/mach-gemini/board-nas4220b.c |  111 +++++++++++++++++++++++++
 arch/arm/mach-gemini/board-wbd111.c   |  143 +++++++++++++++++++++++++++++++++
 arch/arm/mach-gemini/board-wbd222.c   |  143 +++++++++++++++++++++++++++++++++
 6 files changed, 427 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-gemini/board-nas4220b.c
 create mode 100644 arch/arm/mach-gemini/board-wbd111.c
 create mode 100644 arch/arm/mach-gemini/board-wbd222.c
