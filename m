From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jan 2013 17:58:31 +0000
Subject: [GIT PULL] hw_breakpoint updates for 3.9
Message-ID: <20130123175831.GE26811@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these hw_breakpoint updates for 3.9. Nothing major here but
some basic support for debug powerdown with recent CPUs.

Cheers,

Will

--->8

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/hw-breakpoint

for you to fetch changes up to 9a6eb310eaa5336b89a27a0bbb78da4bba35f6f1:

  ARM: hw_breakpoint: Debug powerdown support for self-hosted debug (2013-01-10 21:13:07 +0000)

----------------------------------------------------------------
Dietmar Eggemann (3):
      ARM: coresight: common definition for (OS) Lock Access Register key value
      ARM: hw_breakpoint: Check function for OS Save and Restore mechanism
      ARM: hw_breakpoint: Debug powerdown support for self-hosted debug

 arch/arm/include/asm/cti.h                | 10 +++-------
 arch/arm/include/asm/hardware/coresight.h |  6 +++---
 arch/arm/include/asm/hw_breakpoint.h      |  3 +++
 arch/arm/kernel/hw_breakpoint.c           | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 62 insertions(+), 18 deletions(-)
