From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 30 Sep 2015 12:07:14 +0200
Subject: [GIT PULL] clockevents: a couple of fixes 4.3
Message-ID: <560BB452.1020000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Thomas,

this pull request contains a couple of fixes removing the NO_IRQ usage:

  - Removed bad usage of the NO_IRQ macro which prevent to detect an 
error when calling irq_of_parse_and_map on the rockchip and keystone 
timers (Daniel Lezcano)

Thanks !

   -- Daniel


The following changes since commit eef7635a22f6b144206b5ca2f1398f637acffc4d:

   clockevents: Remove unused set_mode() callback (2015-09-14 11:00:55 
+0200)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/clockevents.git 
clockevents/4.3-fixes

for you to fetch changes up to bdf7344e14d826d0df438a55fc51146d179e198d:

   clocksource/drivers/keystone: Fix bad NO_IRQ usage (2015-09-29 
14:33:51 +0200)

----------------------------------------------------------------
Daniel Lezcano (2):
       clocksource/drivers/rockchip: Fix bad NO_IRQ usage
       clocksource/drivers/keystone: Fix bad NO_IRQ usage

  drivers/clocksource/rockchip_timer.c | 2 +-
  drivers/clocksource/timer-keystone.c | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
