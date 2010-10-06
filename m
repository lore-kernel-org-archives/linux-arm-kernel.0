From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 06 Oct 2010 08:51:42 -0700
Subject: [GIT PULL] MSM changes for v2.6.37
Message-ID: <1286380302.22265.107.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Russell,

Just one GIC fix for 2.6.37 to handle handle_percpu_irq and
handle_edge_irq interrupts correctly.

Please pull, thanks!

Daniel

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:

  Linux 2.6.36-rc5 (2010-09-20 16:56:53 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-russell

Abhijeet Dharmapurikar (1):
      GIC: Dont disable INT in ack callback

 arch/arm/common/gic.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
