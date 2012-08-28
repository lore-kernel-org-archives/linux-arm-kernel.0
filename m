From: davidb@codeaurora.org (David Brown)
Date: Tue, 28 Aug 2012 09:55:32 -0700
Subject: [GIT PULL] msm fixes for v3.6
Message-ID: <20120828165532.GA20947@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-for3.6

for you to fetch changes up to e7501de53aa1a551526872f6c95901a00705f942:

  ARM: msm: Remove call to missing FPGA init on 8660 (2012-08-28 09:39:28 -0700)

----------------------------------------------------------------
Fixes for two problems with MSM:

  - Mapping issue on 7x00 targets.
  - Compilation problems with devicetree on 8660.

----------------------------------------------------------------
David Brown (1):
      ARM: msm: Remove call to missing FPGA init on 8660

Rohit Vaswani (2):
      ARM: msm: io: Remove 7x30 iomap region from 7x00
      ARM: msm: io: Change the default static iomappings to be shared

Stephen Boyd (2):
      ARM: msm: Add handle_irq handler for 8660 DT machine
      ARM: msm: Add msm8660-surf.dts to Makefile.boot

 arch/arm/mach-msm/Makefile.boot   |  2 ++
 arch/arm/mach-msm/board-msm8x60.c |  6 +-----
 arch/arm/mach-msm/io.c            | 28 +++++++++++++++++-----------
 3 files changed, 20 insertions(+), 16 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
