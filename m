From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  9 May 2012 16:08:07 +0200
Subject: [PATCH 0/2] ARM: S3C64xx: cpuidle cleanups
Message-ID: <1336572489-21457-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These couple of patches use the new cpuidle core api to refactor
some part of the code. The first one declares the states directly
in the driver declaration and the second one use the timekeeping
flag to let the cpuidle core to compute the idle time.

I don't have this board, I was not able to test these patches.

Daniel Lezcano (2):
  ARM: s3c64xx: cpuidle - declare the states with the new api
  ARM: s3c64xx: cpuidle - use timekeeping wrapper

 arch/arm/mach-s3c64xx/cpuidle.c |   45 +++++++++++++--------------------------
 1 files changed, 15 insertions(+), 30 deletions(-)

-- 
1.7.5.4
