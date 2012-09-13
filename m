From: davidb@codeaurora.org (David Brown)
Date: Thu, 13 Sep 2012 11:57:36 -0700
Subject: [GIT PULL 4/5] msm board changes
In-Reply-To: <20120913185342.GA29823@codeaurora.org>
References: <20120913185342.GA29823@codeaurora.org>
Message-ID: <20120913185736.GD30032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-board-for-3.7

for you to fetch changes up to 33fcb13dc543af610c7c930dbfeeed6e6ed02376:

  ARM: msm: Allow 8960 and 8660 to compile together (2012-09-13 11:17:47 -0700)

----------------------------------------------------------------
Final parts to allow msm8660 and msm8960 to build into the same
kernel.  This won't work without the changes from msm-dt-for-3.7.

----------------------------------------------------------------
Stephen Boyd (2):
      ARM: msm: Allow msm_iomap-8x60 and msm_iomap-8960 to coexist
      ARM: msm: Allow 8960 and 8660 to compile together

 arch/arm/mach-msm/Kconfig                       |  8 ++++++--
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h | 11 -----------
 arch/arm/mach-msm/include/mach/msm_iomap.h      |  3 +--
 arch/arm/mach-msm/io.c                          |  2 --
 4 files changed, 7 insertions(+), 17 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
