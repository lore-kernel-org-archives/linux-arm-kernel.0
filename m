From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Mar 2016 18:05:58 +0200
Subject: [GIT PULL] at91: soc for 4.7 #1
Message-ID: <1459267558-16328-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A little SoC update with this new chipid code. Pretty simple feature indeed.
If you feel like waiting more material before taking this PR, not problem. I
can also rebase it on another "-rc" if needed.

Thanks, best regards,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-soc

for you to fetch changes up to c07f98a73978964065b57079cae9ab9d060769fe:

  ARM: at91/soc: reference the whole sama5d2 family (2016-03-29 16:34:31 +0200)

----------------------------------------------------------------
First SoC batch for 4.7:
- chipid registers reading for SoC detection

----------------------------------------------------------------
Ludovic Desroches (2):
      ARM: at91: use chipid device for soc detection
      ARM: at91/soc: reference the whole sama5d2 family

 .../devicetree/bindings/arm/atmel-at91.txt         |  4 ++
 arch/arm/mach-at91/sama5.c                         | 20 +++++-
 arch/arm/mach-at91/soc.c                           | 81 +++++++++++++++++-----
 arch/arm/mach-at91/soc.h                           | 12 +++-
 4 files changed, 97 insertions(+), 20 deletions(-)

-- 
Nicolas Ferre
