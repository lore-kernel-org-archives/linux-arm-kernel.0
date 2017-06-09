From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  9 Jun 2017 10:21:09 -0700
Subject: [PATCH v2 0/2] ARM: davinci: misc. VPIF cleanups
Message-ID: <20170609172111.23057-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This are the platforms-specific cleanups needed to go along with the
VPIF cleanups for raw capture support[1], which is now merged in the
media tree.

[1] https://marc.info/?l=linux-arm-kernel&m=149643932427173

Changes since v1:
- fix additional warning in board-dm646x-evm.c
- add DT maintiners in CC for patch 2

Kevin Hilman (2):
  ARM: davinci: pdata-quirks: fix const warnings
  ARM: dts: da850-evm: drop VPIF endpoints

 arch/arm/boot/dts/da850-evm.dts          | 21 ---------------------
 arch/arm/mach-davinci/board-dm646x-evm.c |  4 ++--
 arch/arm/mach-davinci/pdata-quirks.c     |  4 ++--
 3 files changed, 4 insertions(+), 25 deletions(-)

-- 
2.9.3
