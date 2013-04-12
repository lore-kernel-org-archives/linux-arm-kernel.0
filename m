From: davidb@codeaurora.org (David Brown)
Date: Fri, 12 Apr 2013 15:43:44 -0700
Subject: [GIT PULL] msm fixes for 3.10
In-Reply-To: <8ya7gk7qsnp.fsf@huya.qualcomm.com>
Message-ID: <8yar4ifpdy7.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-3.10

for you to fetch changes up to 73a8c28f167c9e7bc42eafc0bcbd298031709430:

  ARM: msm: Fix uncompess.h tx underrun check (2013-04-11 09:40:35 -0700)

----------------------------------------------------------------
Some minor fixes for MSM for 3.10

  - Fix a timer problem that causes missed ticks and hangs.

  - Fix a problem with the decompressor UART dropping characters.

----------------------------------------------------------------
Stephen Boyd (2):
      ARM: msm: Stop counting before reprogramming clockevent
      ARM: msm: Fix uncompess.h tx underrun check

 arch/arm/mach-msm/include/mach/uncompress.h | 2 +-
 arch/arm/mach-msm/timer.c                   | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
