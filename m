From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Oct 2013 21:07:45 +0200
Subject: [PATCH 0/3] clocksource: sun4i: Fix a few minor issues
Message-ID: <1381777668-32565-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here is a few fixes for a few mistakes found during the review of the High
Speed Timers patches, that also applies to the timer code we had previously.

It's mostly a few things here and there, so it can wait for 3.13.

Thanks,
Maxime

Maxime Ripard (3):
  clocksource: sun4i: Select CLKSRC_MMIO
  clocksource: sun4i: Report the minimum tick that we can program
  clocksource: sun4i: remove IRQF_DISABLED

 drivers/clocksource/Kconfig       |  1 +
 drivers/clocksource/sun4i_timer.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.4
