From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  8 Aug 2016 15:33:49 +0200
Subject: [PATCH v2 0/4] clocksource: timer-atmel-pit: driver fix and cleanups
Message-ID: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The first patch in the series is a fix that will be needed starting v4.9. The
remaining patches are cleanups.

Changes in v2:
 - Rebased on v4.8-rc1
 - Collected acks

Alexandre Belloni (4):
  clocksource: timer-atmel-pit: enable mck
  clocksource: timer-atmel-pit: drop at91sam926x_pit_common_init
  clocksource: timer-atmel-pit: remove uselesss WARN_ON_ONCE
  clocksource: timer-atmel-pit: simplify IRQ handler

 drivers/clocksource/timer-atmel-pit.c | 78 +++++++++++++----------------------
 1 file changed, 29 insertions(+), 49 deletions(-)

-- 
2.8.1
