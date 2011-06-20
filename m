From: davidb@codeaurora.org (David Brown)
Date: Mon, 20 Jun 2011 16:42:27 -0700
Subject: [GIT PULL] msm fixes for 3.0-rc4
Message-ID: <8yar56onk7w.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:

  Linux 3.0-rc3 (2011-06-13 15:29:59 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix

Jeff Ohlstein (1):
      msm: timer: compensate for timer shift in msm_read_timer_count

Stephen Boyd (2):
      msm: timer: Fix SMP build error
      msm: timer: Fix DGT rate on 8960 and 8660

 arch/arm/mach-msm/timer.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
