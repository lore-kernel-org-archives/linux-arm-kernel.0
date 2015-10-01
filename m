From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 1 Oct 2015 14:33:39 +0200
Subject: [GIT PULL] at91: soc for 4.4 #1
Message-ID: <1443702819-32032-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is our first SoC batch for 4.4 and it's quite little.
Some content may come later but we still have to figure out if it goes through
arm-soc or the clock tree by Mike.

Thanks, best regards,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-soc

for you to fetch changes up to 6f112a08c1ed717a015dae190e289d53085c1bc4:

  ARM: at91: debug: use DEBUG_UART_PHYS (2015-09-21 16:31:15 +0200)

----------------------------------------------------------------
First little batch of SoC changes for 4.4:
- a MAINTAINER addition to cover SAMA5 SoCs
- removal of one unneeded header file
- for low-level serial output, use the DEBUG_UART_PHYS

----------------------------------------------------------------
Alexandre Belloni (3):
      MAINTAINERS: explicitly add Atmel SAMA5
      ARM: at91: remove useless includes in platform_data/atmel.h
      ARM: at91: debug: use DEBUG_UART_PHYS

 MAINTAINERS                         |  2 +-
 arch/arm/Kconfig.debug              | 41 ++++++++++++++---------------------
 arch/arm/include/debug/at91.S       | 18 ++++-----------
 include/linux/platform_data/atmel.h |  8 -------
 4 files changed, 21 insertions(+), 48 deletions(-)

-- 
Nicolas Ferre
