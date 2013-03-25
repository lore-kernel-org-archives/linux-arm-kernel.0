From: davidb@codeaurora.org (David Brown)
Date: Mon, 25 Mar 2013 14:43:32 -0700
Subject: [GIT PULL] msm fix for 3.9 -- timer
Message-ID: <8ya8v5b88aj.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-3.9

for you to fetch changes up to 4080d2d11a2d572228c2b8d02406e997b87ba6a5:

  ARM: msm: Stop counting before reprogramming clockevent (2013-03-22 10:45:39 -0700)

----------------------------------------------------------------
This fix is intended for v3.9.  It fixes a timer bug on MSM targets
that cause system hangs.

----------------------------------------------------------------
Stephen Boyd (1):
      ARM: msm: Stop counting before reprogramming clockevent

 arch/arm/mach-msm/timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
