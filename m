From: davidb@codeaurora.org (David Brown)
Date: Fri, 13 Apr 2012 11:08:40 -0700
Subject: [GIT PULL] msm fixes for 3.4rc
Message-ID: <20120413180840.GA17558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd/Olof.  Here are some fixes for msm that fix problems caused by
the latest ARM code.  The ones from Daniel remove unneeded fixups that
now cause compilation failures.  Mine fix section mismatches, that
were incompletely fixed earlier.

Thanks,
David

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git msm-fix

for you to fetch changes up to af33eadc73e4a5d35a966c1c7ffe28a8424c9d96:

  ARM: msm: Fix section mismatches in proc_comm.c (2012-04-13 10:23:17 -0700)

----------------------------------------------------------------
Daniel Walker (2):
      arm: msm: halibut: remove unneeded fixup
      arm: msm: trout: fix compile failure

David Brown (2):
      video: msm: Fix section mismatches in mddi.c
      ARM: msm: Fix section mismatches in proc_comm.c

 arch/arm/mach-msm/board-halibut.c     |    3 ---
 arch/arm/mach-msm/board-trout-panel.c |    1 +
 arch/arm/mach-msm/board-trout.c       |    1 +
 arch/arm/mach-msm/proc_comm.c         |    2 +-
 drivers/video/msm/mddi.c              |    8 ++++----
 5 files changed, 7 insertions(+), 8 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
