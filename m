From: davidb@codeaurora.org (David Brown)
Date: Wed, 9 Nov 2011 17:00:03 -0800
Subject: [GIT PULL] msm fixes for 3.2
Message-ID: <20111110010003.GA785@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This contains an additional fix from
https://lkml.org/lkml/2011/11/1/345
so that pull request can be ignored.

The following changes since commit b4beb4bf9934d151bf4581a54ae028927374cb2a:

  Merge branch 'for-linus/i2c-3.2' of git://git.fluff.org/bjdooks/linux (2011-11-01 15:07:19 -0700)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix

Marc Zyngier (1):
      ARM: msm: fix compilation flags for MSM_SCM

Stephen Boyd (1):
      msm: boards: Fix fallout from removal of machine_desc in fixup

 arch/arm/mach-msm/Makefile        |    2 ++
 arch/arm/mach-msm/board-msm7x30.c |    4 ++--
 arch/arm/mach-msm/board-msm8960.c |    4 ++--
 arch/arm/mach-msm/board-msm8x60.c |    4 ++--
 arch/arm/mach-msm/scm.c           |    3 +++
 5 files changed, 11 insertions(+), 6 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
