From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Feb 2012 09:44:42 +0100
Subject: [GIT PULL] One more =?UTF-8?Q?sched=5Fclock=28=29=20patch?=
Message-ID: <322c288d3ad6aecc8014e0a3582c8527@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Russell,

Could you please pull from my sched_clock-for-rmk branch again?
It contains a single additional patch. courtesy of Stephen Boyd, that
contains support for sched_clock() on msm. The rest of the branch is
unchanged.

Thanks,

        M.

The following changes since commit
6905a65879b51d326396e63dfea40861a30bc17f:

  ARM: Make the sched_clock framework mandatory (2012-02-03 11:34:27
+0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
sched_clock-for-rmk

Stephen Boyd (1):
      msm: timer: Support sched_clock()

 arch/arm/mach-msm/timer.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

-- 
Fast, cheap, reliable. Pick two.
