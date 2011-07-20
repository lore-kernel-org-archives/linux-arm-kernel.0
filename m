From: davidb@codeaurora.org (David Brown)
Date: Wed, 20 Jul 2011 13:37:03 -0700
Subject: [GIT PULL] MSM fix
Message-ID: <20110720203703.GA4495@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I seem to have missed this fix when it was sent out in April.

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix

Jeff Ohlstein (1):
      msm: platsmp: actually read core count in get_core_count

 arch/arm/mach-msm/platsmp.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
