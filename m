From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 15 Feb 2013 22:00:56 +0900
Subject: [PATCH 0/4] ARM: shmobile: kzm9g reference SMP and cleanup
Message-ID: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series tweaks the defconfig to allow SMP kzm9g reference
to successfully boot. The series also contains a number of cleanups.

The series is based on the boards-kzm9g-reference branch
in the renesas tree.

Simon Horman (5):
  ARM: shmobile: kzm9g: defconfig: do not enable PREEMPT
  ARM: shmobile: kzm9g: Remove warning about SMP
  ARM: shmobile: sh73a0: Remove sh73a0_init_irq_dt()
  ARM: shmobile: sh73a0: Add smp ops to DT_MACHINE_START
  ARM: shmobile: kzm9g: Trim reference DT_MACHINE_START

 arch/arm/configs/kzm9g_defconfig               |    1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   19 ++-----------------
 arch/arm/mach-shmobile/intc-sh73a0.c           |    8 --------
 arch/arm/mach-shmobile/setup-sh73a0.c          |    4 +++-
 4 files changed, 5 insertions(+), 27 deletions(-)
