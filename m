From: baruch@tkos.co.il (Baruch Siach)
Date: Wed,  9 Jun 2010 14:06:59 +0300
Subject: [PATCH 0/3] MX25 watchdog
Message-ID: <cover.1276081393.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the new watchdog driver on the i.MX25 PDK 
platform. A little fix to the watchdog driver itself is also added.

Baruch Siach (3):
  mx25: add watchdog clock
  mx25pdk: register watchdog device
  imx2_wdt: fix section mismatch

 arch/arm/mach-mx25/clock.c        |    2 ++
 arch/arm/mach-mx25/mach-mx25pdk.c |    1 +
 drivers/watchdog/imx2_wdt.c       |    1 -
 3 files changed, 3 insertions(+), 1 deletions(-)
