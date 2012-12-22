From: mikedunn@newsguy.com (Mike Dunn)
Date: Sat, 22 Dec 2012 11:31:56 -0800
Subject: [PATCH 0/3] ARM: pxa: palmtreo: a few treo fixes
Message-ID: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some miscellaneous fixes to the treo code.

Mike Dunn (3):
  ARM: pxa: palmtreo: fix lcd initialization on treo680
  ARM: pxa: palmtreo: fix #ifdefs for leds-gpio device
  ARM: pxa: palmtreo: add docg4 device initialization

 arch/arm/mach-pxa/include/mach/palmtreo.h |    3 +
 arch/arm/mach-pxa/palmtreo.c              |  102 ++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 9 deletions(-)

-- 
1.7.8.6
