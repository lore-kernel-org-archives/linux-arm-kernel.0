From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jul 2017 17:22:45 +0200
Subject: [PATCH v2 0/3] normalize clk API for older platforms
Message-ID: <20170721152250.3310552-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the earlier feedback so far, I have split out the patch
per platform, improved the davinci implementation, dropped both
ep93xx (which has a proper implementation coming) and mmp (which
is dead code anyway), and decided to do the sa1100 implementation
differnently (without warning).

       Arnd

Arnd Bergmann (3):
  ARM: davinci: normalize clk API
  ARM: sa1100: normalize clk API
  ARM: w90x900: normalize clk API

 arch/arm/mach-davinci/clock.c |  9 +++++++++
 arch/arm/mach-sa1100/clock.c  | 25 +++++++++++++++++++++++++
 arch/arm/mach-w90x900/clock.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

-- 
2.9.0
