From: davidb@codeaurora.org (David Brown)
Date: Tue, 24 Apr 2012 10:54:57 -0700
Subject: [GIT PULL] msm fixes for 3.4rc
Message-ID: <20120424175457.GA5013@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a boot problem with the MSM8660 target on device tree
caused by the conversion of the ARM GIC driver to proper IRQ domain
support.

The following changes since commit af33eadc73e4a5d35a966c1c7ffe28a8424c9d96:

  ARM: msm: Fix section mismatches in proc_comm.c (2012-04-13 10:23:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git msm-fix

for you to fetch changes up to 2b7b9a7d6c676691cd746a654e2c3b06a6feb9ba:

  ARM: msm: Fix gic irqdomain support (2012-04-23 16:13:27 -0700)

----------------------------------------------------------------
David Brown (1):
      ARM: msm: Fix gic irqdomain support

 arch/arm/boot/dts/msm8660-surf.dts |    4 ++--
 arch/arm/mach-msm/board-msm8x60.c  |   25 +++++++++++++++----------
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
