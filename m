From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 21 Jan 2010 17:00:21 +0200
Subject: [PATCH 0/2] mx25: clock related fixes
Message-ID: <cover.1264085584.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix two issues related to the clock configuration in the i.MX25
platform code. In the coming days I'll work on a better fix for the i.MX25 
clock infrastructure.

Baruch Siach (2):
  mx25: remove unused mx25_clocks_init() argument
  mx25: properly initialize clocks, fix time accounting

 arch/arm/mach-mx25/clock.c              |   29 +++++++++++++++++++++++++++--
 arch/arm/mach-mx25/mx25pdk.c            |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |    2 +-
 3 files changed, 29 insertions(+), 4 deletions(-)
