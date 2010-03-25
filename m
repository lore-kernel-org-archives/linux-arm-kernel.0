From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 25 Mar 2010 16:35:55 -0700
Subject: [GIT PULL] generic arm for MSM try2
Message-ID: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, attempt #2 .. It's the same set of patches , only it's against
mainline linus tree of the moment. I force updated it into the same
"for-russell" branch.

btw, you might want to pay close attention to the "Fix incorrect
permission faults" patch. That's the only non-small patch in the queue.

Let me know if I need to do attempt #3 ..

The following changes since commit 1097d7cef683c30f9768007daae2e961a0686a10:
  Linus Torvalds (1):
        Merge branch 'urgent' of git://git.kernel.org/.../brodo/pcmcia-2.6

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
