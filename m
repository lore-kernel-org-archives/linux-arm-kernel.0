From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 20 Apr 2010 11:18:57 -0700
Subject: [GIT PULL] generic arm for MSM try 3
Message-ID: <1271787537.1986.10.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I dropped the copyright and rebased, but everything else is the same as
the prior pull request.

The following changes since commit 27ee8963708185b96bc84a149eb5336a249a7497:
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
