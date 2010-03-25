From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 25 Mar 2010 14:52:17 -0700
Subject: [GIT PULL] generic arm for MSM
Message-ID: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are all mostly small patches that I've sent out a few times with
no comments. Let me know if you see any issues.

The following changes since commit 7ee744f22ffad619e23912a22d1b2795e10ed825:
  Stephen Rothwell (1):
        Add linux-next specific files for 20100324

are available in the git repository at:

  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-russell

Daniel Walker (2):
      arm: msm: allow ARCH_MSM to have v7 cpus
      arm: msm: add oprofile pmu support

Dave Estes (1):
      arm: mm: qsd8x50: Fix incorrect permission faults

Steve Muckle (1):
      arm: msm: define HAVE_CLK for ARCH_MSM

 arch/arm/Kconfig          |   11 ++++++-----
 arch/arm/kernel/pmu.c     |    2 ++
 arch/arm/mach-msm/Kconfig |    2 ++
 arch/arm/mm/Kconfig       |    2 ++
 arch/arm/mm/abort-ev7.S   |   38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 5 deletions(-)
