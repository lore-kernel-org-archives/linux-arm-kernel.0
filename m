From: davidb@codeaurora.org (David Brown)
Date: Mon, 7 May 2012 14:58:28 -0700
Subject: [GIT PULL] msm-core changes for v3.5.
Message-ID: <20120507215828.GA21748@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are some minor fixes, and Daniel's fixup of the sapphire target
support.

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git msm-core

for you to fetch changes up to 2935b1facdfb77d5f03d9036cc0da8c889f59a02:

  ARM: msm: fix compilation flags for MSM_SCM (part 2) (2012-05-01 16:44:11 -0700)

----------------------------------------------------------------
Daniel Walker (1):
      arm: msm: fix up very basic HTC Sapphire support

Danny Kukawka (1):
      arch/arm/mach-msm: linux/gpio.h included twice

Stephen Boyd (2):
      ARM: msm: Drop useless teq from DEBUG_LL support
      ARM: msm: fix compilation flags for MSM_SCM (part 2)

 arch/arm/mach-msm/Kconfig                    |   10 +-
 arch/arm/mach-msm/Makefile                   |    1 +
 arch/arm/mach-msm/board-msm7x30.c            |    1 -
 arch/arm/mach-msm/board-qsd8x50.c            |    1 -
 arch/arm/mach-msm/board-sapphire.c           |   18 +--
 arch/arm/mach-msm/board-sapphire.h           |  224 ++++++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/debug-macro.S |    3 +-
 arch/arm/mach-msm/scm.c                      |    3 +
 8 files changed, 239 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-sapphire.h

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
