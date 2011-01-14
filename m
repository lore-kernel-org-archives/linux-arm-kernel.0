From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 14 Jan 2011 19:00:16 +0100
Subject: [GIT PULL] AT91: patches for v2.6.38-rc1
Message-ID: <4D308F30.6070503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Can you please pull those little changes for AT91? They add two 
new boards already discussed on the mailing list and a little 
cleanup patch:

The following changes since commit 9e9bc9736756f25d6c47b4eba0ebf25b20a6f153:

  Merge branch 'v4l_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-2.6 (2011-01-06 18:32:12 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-2.6-at91.git for_rmk

Igor Plyatov (1):
      AT91: Support for gsia18s board

Jesper Juhl (1):
      AT91: board-sam9m10g45ek.c: Remove duplicate inclusion of mach/hardware.h

Sergio Tanzilli (1):
      AT91: Acme Systems FOX Board G20 board files

 arch/arm/mach-at91/Kconfig                |   13 +
 arch/arm/mach-at91/Makefile               |    2 +
 arch/arm/mach-at91/board-foxg20.c         |  274 ++++++++++++++
 arch/arm/mach-at91/board-gsia18s.c        |  584 +++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9m10g45ek.c   |    1 -
 arch/arm/mach-at91/include/mach/gsia18s.h |   33 ++
 6 files changed, 906 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-foxg20.c
 create mode 100644 arch/arm/mach-at91/board-gsia18s.c
 create mode 100644 arch/arm/mach-at91/include/mach/gsia18s.h

Thanks, best regards,
-- 
Nicolas Ferre
