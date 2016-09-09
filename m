From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  9 Sep 2016 13:13:47 +0200
Subject: [PATCH v4 0/3] clocksource: timer-atmel-pit: driver cleanups
Message-ID: <20160909111350.27534-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

This is just the cleanup part of the previous seris as the fix has been applied.

It is rebased on top of v4.8-rc5 and should apply cleanly.

Alexandre Belloni (3):
  clocksource: timer-atmel-pit: drop at91sam926x_pit_common_init
  clocksource: timer-atmel-pit: remove uselesss WARN_ON_ONCE
  clocksource: timer-atmel-pit: simplify IRQ handler

 drivers/clocksource/timer-atmel-pit.c | 96 ++++++++++++++---------------------
 1 file changed, 37 insertions(+), 59 deletions(-)

-- 
2.9.3
