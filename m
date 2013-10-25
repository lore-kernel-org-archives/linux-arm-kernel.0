From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Oct 2013 12:16:09 +0100
Subject: [PATCH 0/2] More Allwinner SoC timer fixes
Message-ID: <1382699771-4396-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are more fixes to the sun4i timer that we spotted during the review of the
High Speed timers patches, and that we hunted down during the Kernel Summit.

Since they are not critical fixes for the current code we have, it doesn't have
to be merged in 3.12 and can wait.

Thanks!
Maxime

Maxime Ripard (2):
  clockevent: sun4i: Fill the irq field in the clockevent structure
  clocksource: sun4i: change CPU mask to cpu_possible_mask

 drivers/clocksource/sun4i_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.4
