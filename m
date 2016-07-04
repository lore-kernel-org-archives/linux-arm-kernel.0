From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  5 Jul 2016 00:12:31 +0200
Subject: [PATCH 0/3] clocksource: timer-atmel-pit: driver cleanup
Message-ID: <1467670354-12987-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are a few cleanups I had laying around for a while. I rebased and
tested on top of 4.7-rc1.

The series will apply after:
"clocksource: timer-atmel-pit: enable mck"


Alexandre Belloni (3):
  clocksource: timer-atmel-pit: drop at91sam926x_pit_common_init
  clocksource: timer-atmel-pit: remove uselesss WARN_ON_ONCE
  clocksource: timer-atmel-pit: simplify IRQ handler

 drivers/clocksource/timer-atmel-pit.c | 76 ++++++++++++++---------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

-- 
2.8.1
