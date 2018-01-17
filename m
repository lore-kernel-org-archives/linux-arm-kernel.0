From: ladis@linux-mips.org (Ladislav Michl)
Date: Wed, 17 Jan 2018 22:46:29 +0100
Subject: [PATCH 0/3] omap: dmtimer: Fix and cleanup moved driver
Message-ID: <20180117214629.GA11952@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is build on top od Keerthy's 'omap: dmtimer: Move driver
out of plat-omap' v7.

Ladislav Michl (3):
  clocksource: timer-dm: Check prescaler value
  pwm: pwm-omap-dmtimer: Fix frequency when using prescaler
  clocksource: timer-dm: Make unexported functions static

 drivers/clocksource/timer-dm.c |  222 ++++++++++++++++++++---------------------
 drivers/pwm/pwm-omap-dmtimer.c |   92 +++++++++-------
 include/clocksource/dmtimer.h  |   24 ----
 3 files changed, 164 insertions(+), 174 deletions(-)
