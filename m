From: davidb@codeaurora.org (David Brown)
Date: Fri, 12 Apr 2013 15:43:15 -0700
Subject: [GIT PULL] msm core for 3.10
In-Reply-To: <8ya7gk7qsnp.fsf@huya.qualcomm.com>
Message-ID: <8yazjx3pdz0.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-core-3.10

for you to fetch changes up to e25e3d1fef2c57e49aef64535341c15fe2b29b4a:

  ARM: msm: Wait for timer clear to complete (2013-03-22 10:46:16 -0700)

----------------------------------------------------------------
Patches for MSM core

These patches are changes to the MSM timer code that will be for
upcoming targets, including a generalization of the binding and
preventing a missing timer interrupt.

----------------------------------------------------------------
Stephen Boyd (2):
      ARM: msm: Rework timer binding to be more general
      ARM: msm: Wait for timer clear to complete

 .../devicetree/bindings/arm/msm/timer.txt          |  41 ++++----
 arch/arm/boot/dts/msm8660-surf.dts                 |  20 ++--
 arch/arm/boot/dts/msm8960-cdp.dts                  |  22 ++---
 arch/arm/mach-msm/timer.c                          | 110 ++++++++++-----------
 4 files changed, 86 insertions(+), 107 deletions(-)

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
