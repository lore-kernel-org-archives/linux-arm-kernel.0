From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 14:36:22 -0800
Subject: [GIT PULL for 38-rc2] msm: initdata fix
Message-ID: <8ya8vygo715.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I seem to have missed this fix for the rc1.  Without it, access to
/sys entries for the ethernet access freed memory.

Thanks,
David

The following changes since commit c56eb8fb6dccb83d9fe62fd4dc00c834de9bc470:

  Linux 2.6.38-rc1 (2011-01-18 15:14:02 -0800)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git for-38-rc2

Stephen Boyd (1):
      msm: qsd8x50: Platform data isn't init data

 arch/arm/mach-msm/board-qsd8x50.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
