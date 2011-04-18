From: davidb@codeaurora.org (David Brown)
Date: Mon, 18 Apr 2011 15:40:18 -0700
Subject: [GIT PULL for 39-rc4] msm: minor fixes
Message-ID: <8ya8vv7xjxp.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are some minor fixes to ARM's MSM.  I would have sent them
earlier, but was on vacation.

The following changes since commit 0ce790e7d736cedc563e1fb4e998babf5a4dbc3d:

  Linux 2.6.39-rc1 (2011-03-29 12:09:47 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git for-39-rc4

David Brown (2):
      msm: Remove extraneous ffa device check
      msm: timer: fix missing return value

 arch/arm/mach-msm/board-qsd8x50.c |    5 +----
 arch/arm/mach-msm/timer.c         |    2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
