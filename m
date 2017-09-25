From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 25 Sep 2017 13:46:38 +0530
Subject: [PATCH 0/3] clocksource: pr_err() strings should end with newlines
Message-ID: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should terminated with a new-line to avoid
other messages being concatenated onto the end.

Arvind Yadav (3):
  [PATCH 1/3] clocksource: fttmr010: pr_err() strings should end with newlines
  [PATCH 2/3] clocksource: owl: pr_err() strings should end with newlines
  [PATCH 3/3] clocksource: rockchip: pr_err() strings should end with newlines

 drivers/clocksource/owl-timer.c      | 4 ++--
 drivers/clocksource/rockchip_timer.c | 2 +-
 drivers/clocksource/timer-fttmr010.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.9.1
