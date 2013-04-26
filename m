From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 26 Apr 2013 14:17:13 +0200
Subject: [PATCH 0/5] various ab8500 fixes
Message-ID: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

this series contains various fixes I found on the current -next ab8500
driver(s).

Patches 1 and 2 are just sparse warning, patch 3 drops reference to a
superseeded driver and last two makes ab8500-sysctrl works again without
an explicit ab8500->sysctrl defined, as it is in current kernel.

Thanks,
Fabio


Fabio Baltieri (5):
  mfd: abx500-core: fix sparse warning
  mfd: ab8500-sysctrl: fix sparse warning
  mfd: ab8500: drop references to ab8500-leds
  mfd: ab8500-sysctrl: set sysctrl_dev during probe
  mfd: ab8500-sysctrl: let sysctrl driver work without pdata

 drivers/mfd/ab8500-core.c    | 13 -------------
 drivers/mfd/ab8500-sysctrl.c |  9 +++++----
 drivers/mfd/abx500-core.c    |  2 +-
 3 files changed, 6 insertions(+), 18 deletions(-)

-- 
1.8.1.3
