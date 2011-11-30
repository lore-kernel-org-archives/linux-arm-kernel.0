From: davidb@codeaurora.org (David Brown)
Date: Wed, 30 Nov 2011 15:36:26 -0800
Subject: [GIT PULL] msm misc changes for 3.3
Message-ID: <20111130233626.GA26687@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-misc

Stephen Boyd (3):
      ARM: msm: Consolidate and move DEBUG_LL to DEBUG_LL choice
      msm: Support DEBUG_LL on MSM8660 and MSM8960
      msm: platsmp: Mark ioremapped memory as __iomem

 arch/arm/Kconfig.debug                          |   37 ++++++++++++++++
 arch/arm/mach-msm/Kconfig                       |   35 +--------------
 arch/arm/mach-msm/include/mach/debug-macro.S    |   51 ++++++++++++++--------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |   12 -----
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |   12 -----
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |    5 ++
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |   12 -----
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    5 ++
 arch/arm/mach-msm/include/mach/msm_iomap.h      |   12 +++++
 arch/arm/mach-msm/include/mach/uncompress.h     |   39 ++++++++++++++----
 arch/arm/mach-msm/io.c                          |   15 +++++-
 arch/arm/mach-msm/platsmp.c                     |    2 +-
 12 files changed, 138 insertions(+), 99 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
