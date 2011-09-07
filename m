From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 7 Sep 2011 10:30:24 +0200
Subject: [PATCH 0/4] Integrator/AP clockevent patches
Message-ID: <1315384224-27298-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This cleans up and modernize the clock event registration
for the Integrator/AP. All have been tested on the real
hardware and works fine for my setup.

I will try to push this through Russell's patch tracker
unless someone yells that it needs to go through the SoC
tree, since I guess Russell has some interest in this
machine.

Linus Walleij (4):
  mach-integrator: retire some timer macros
  mach-integrator: clockevent supports oneshot mode
  mach-integrator: modernize clock event registration
  mach-integrator: get timer frequency from clock

 arch/arm/mach-integrator/core.c                  |    4 +
 arch/arm/mach-integrator/include/mach/platform.h |   12 ---
 arch/arm/mach-integrator/integrator_ap.c         |   83 ++++++++++-----------
 3 files changed, 44 insertions(+), 55 deletions(-)

-- 
1.7.3.2
