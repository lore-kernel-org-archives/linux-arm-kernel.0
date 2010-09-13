From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 13 Sep 2010 13:05:50 -0700
Subject: [GIT PULL] generic arm MSM changes for v2.6.37 -v2
Message-ID: <1284408350.4003.45.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Here is a replacement pull request. It's the same changes as the last
one I sent, only without the SMP Kconfig change.

I sent the SMP Kconfig change as a separate patch against your devel
tree.

Daniel


The following changes since commit 49553c2ef88749dd502687f4eb9c258bb10a4f44:

  Linux 2.6.36-rc4 (2010-09-12 16:07:37 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-russell

Abhijeet Dharmapurikar (1):
      GIC: Dont disable INT in ack callback

Daniel Walker (2):
      arm: dis-allow hotplug on MSM
      arm: mm: add proc info for ARM11MPCore/Cortex-A9 from ARM

 arch/arm/Kconfig      |    1 +
 arch/arm/common/gic.c |   14 --------------
 arch/arm/mm/proc-v7.S |   26 +++++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 15 deletions(-)

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
