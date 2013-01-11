From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:28:55 +0000
Subject: [PATCH 0/3] hw_breakpoint updates for 3.9
Message-ID: <1357918138-20222-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a small handful of hw_breakpoint updates, all from Dietmar, that
I plan to send via Russell for 3.9.

Any comments, please shout.

Will


Dietmar Eggemann (3):
  ARM: coresight: common definition for (OS) Lock Access Register key
    value
  ARM: hw_breakpoint: Check function for OS Save and Restore mechanism
  ARM: hw_breakpoint: Debug powerdown support for self-hosted debug

 arch/arm/include/asm/cti.h                | 10 ++---
 arch/arm/include/asm/hardware/coresight.h |  6 +--
 arch/arm/include/asm/hw_breakpoint.h      |  3 ++
 arch/arm/kernel/hw_breakpoint.c           | 61 +++++++++++++++++++++++++++----
 4 files changed, 62 insertions(+), 18 deletions(-)

-- 
1.8.0
