From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:22 +0900
Subject: [GIT PULL] Second Round Of Renesas ARM Based SoC Updates For v3.18
Message-ID: <cover.1408927858.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-for-v3.18,
which I have already sent a pull-request for.


The following changes since commit 5ac9e7f35db00e630c9f95a1f73ac329371cdbbf:

  ARM: shmobile: sh73a0: Remove unneeded nr_irqs initialization (2014-08-20 09:09:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.18

for you to fetch changes up to 86155b35d173317518458c6f9c0a3ea8c5324bed:

  ARM: shmobile: Move legacy INTC definitions from irqs.h to intc.h (2014-08-22 12:23:32 +0900)

----------------------------------------------------------------
Second Round Of Renesas ARM Based SoC Updates For v3.18

* Move legacy INTC definitions from irqs.h to intc.h
* Remove duplicate CPUFreq bits on r8a73a0/ape6evm

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Move legacy INTC definitions from irqs.h to intc.h

Magnus Damm (2):
      ARM: shmobile: sh73a0: Remove duplicate CPUFreq bits
      ARM: shmobile: ape6evm: Remove duplicate CPUFreq bits

 arch/arm/mach-shmobile/board-ape6evm-reference.c | 1 -
 arch/arm/mach-shmobile/board-kzm9g.c             | 1 +
 arch/arm/mach-shmobile/board-mackerel.c          | 1 +
 arch/arm/mach-shmobile/intc.h                    | 5 +++++
 arch/arm/mach-shmobile/irqs.h                    | 6 ------
 arch/arm/mach-shmobile/setup-sh7372.c            | 1 +
 arch/arm/mach-shmobile/setup-sh73a0.c            | 6 +-----
 7 files changed, 9 insertions(+), 12 deletions(-)
