From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Jun 2017 16:12:08 -0700
Subject: [PATCH 0/2] ARM: davinci: misc. VPIF cleanups 
Message-ID: <20170602231210.19553-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This are the platforms-specific cleanups needed to go along with the
VPIF cleanups for raw capture support here:

   https://marc.info/?l=linux-arm-kernel&m=149643932427173

Kevin Hilman (2):
  ARM: davinci: pdata-quirks: fix const warnings
  ARM: dts: da850-evm: drop VPIF endpoints

 arch/arm/boot/dts/da850-evm.dts      | 21 ---------------------
 arch/arm/mach-davinci/pdata-quirks.c |  4 ++--
 2 files changed, 2 insertions(+), 23 deletions(-)

-- 
2.9.3
