From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Fri, 23 Jul 2010 11:58:00 -0700
Subject: [PATCH 0/3] ARM changes for ScorpionMP support
Message-ID: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are low level changes needed to support targets based on Qualcomm's
ScorpionMP architecture.

Jeff Ohlstein (1):
  arm: Kconfig option for ARCH_MSM_SCORPIONMP

Steve Muckle (2):
  arm: mm: do not set missing flags on ScorpionMP
  arm: macros for wfe, sev instructions

 arch/arm/Kconfig                 |    5 +++--
 arch/arm/include/asm/processor.h |    5 +++++
 arch/arm/mach-msm/Kconfig        |    2 ++
 arch/arm/mm/proc-v7.S            |    2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
