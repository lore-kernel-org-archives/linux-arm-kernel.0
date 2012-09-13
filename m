From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 13 Sep 2012 17:25:33 +0530
Subject: [RFC] [PATCH 0/2] ARM: EXYNOS4: Add new cpuidle state
Message-ID: <1347537335-26657-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does following:

Patch 1: Segregate and move common code to new function
Patch 2: Adds C2 idle state

It has been tested on Kukjin's for-next branch on Origen board.

Chander Kashyap (2):
  ARM: Exynos4: CPUIDLE: Add generic function for exynos4 cpuidle
  ARM: EXYNOS4: CPUIDLE: Add C2 state

 arch/arm/mach-exynos/cpuidle.c |  385 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 373 insertions(+), 12 deletions(-)

-- 
1.7.9.5
