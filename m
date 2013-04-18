From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 16:51:42 +0200
Subject: [GIT PULL] at91: soc for 3.10 #3
Message-ID: <1366296702-26436-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Third pull-request for AT91 SoC support based on material that you already have
in your arm-soc/at91/soc branch.
Not very core changes here but interesting enhancements.

Thanks, best regards,

The following changes since commit 471c9e786596c4f028c67c7e9de0703b49cab2a9:

  ARM: at91: add defconfig for SAMA5 (2013-03-26 12:18:05 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-soc

for you to fetch changes up to f5fa4098c3fcc0e504fbc0682dccd331dbbcf197:

  ARM: at91: suspend both memory controllers on at91sam9263 (2013-04-18 16:31:02 +0200)

----------------------------------------------------------------
Little modification in SoC presentation in kernel log.
Removing of a long-standing warning in sam9263 PM code.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: at91: suspend both memory controllers on at91sam9263

Nicolas Ferre (1):
      ARM: at91: change "Unknown" qualifier SoC subtype handling

 arch/arm/mach-at91/cpuidle.c          |  2 ++
 arch/arm/mach-at91/include/mach/cpu.h |  9 ++++++---
 arch/arm/mach-at91/pm.c               |  2 ++
 arch/arm/mach-at91/pm.h               | 30 ++++++++++++++++++++++++------
 arch/arm/mach-at91/setup.c            | 22 +++++++++++++++-------
 5 files changed, 49 insertions(+), 16 deletions(-)

-- 
Nicolas Ferre
