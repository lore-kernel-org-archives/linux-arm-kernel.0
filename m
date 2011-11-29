From: davidb@codeaurora.org (David Brown)
Date: Tue, 29 Nov 2011 11:39:08 -0800
Subject: [GIT PULL] msm: timer updates for 3.3
Message-ID: <20111129193908.GA1760@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-timer

Stephen Boyd (8):
      msm: timer: Tighten #ifdef for local timer support
      msm: timer: Cleanup #includes and #defines
      msm: timer: Use GPT for clockevents and DGT for clocksource
      msm: timer: Fix ONESHOT mode interrupts
      msm: timer: Remove msm_clocks[] and simplify code
      msm: timer: Remove SoC specific #ifdefs
      msm: timer: Setup interrupt after registering clockevent
      msm: timer: Use clockevents_config_and_register()

 arch/arm/mach-msm/timer.c |  347 ++++++++++++++++-----------------------------
 1 files changed, 124 insertions(+), 223 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
