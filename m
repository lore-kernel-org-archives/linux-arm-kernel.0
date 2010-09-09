From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu,  9 Sep 2010 12:58:05 -0700
Subject: [GIT PULL] generic arm MSM changes for v2.6.37
Message-ID: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I'm sending out the actual patches even tho most of this has been
discussed already. The proc-info change was suggested by Catalin, but
I didn't see you given an Ack so I wanted to make sure that was OK.
The other thing is that I know there are changes in your devel tree
which conflict with the Kconfig changes I'm making.

If it's all ok, please consider pulling this.

Daniel


The following changes since commit 2bfc96a127bc1cc94d26bfaa40159966064f9c8c:

  Linux 2.6.36-rc3 (2010-08-29 08:36:04 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-russell

Abhijeet Dharmapurikar (1):
      GIC: Dont disable INT in ack callback

Daniel Walker (2):
      arm: dis-allow hotplug on MSM
      arm: mm: add proc info for ARM11MPCore/Cortex-A9 from ARM

Steve Muckle (1):
      arm: Kconfig option for ARCH_MSM_SCORPIONMP

 arch/arm/Kconfig          |    7 +++++--
 arch/arm/common/gic.c     |   14 --------------
 arch/arm/mach-msm/Kconfig |    2 ++
 arch/arm/mm/proc-v7.S     |   26 +++++++++++++++++++++++++-
 4 files changed, 32 insertions(+), 17 deletions(-)
