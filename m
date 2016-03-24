From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 13:08:48 +0800
Subject: [PATCH 0/2] arm64: cpuidle: make arm_cpuidle_suspend() more efficient
Message-ID: <1458796130-6109-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is to improve the arm_cpuidle_suspend() a bit by removing/moving
out checks from this hot path.

Jisheng Zhang (2):
  arm64: cpuidle: remove cpu_ops check from arm_cpuidle_suspend()
  arm64: cpuidle: make arm_cpuidle_suspend() a bit more efficient

 arch/arm64/kernel/cpuidle.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.8.0.rc3
