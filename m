From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 16:00:12 -0700
Subject: [PATCH 0/2] 8660 DT fixlets
Message-ID: <1345676414-16635-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two small fixes to 8660 DT support so that it boots up
and gets interrupts and so that we can build the dtb via
kernel Makefiles with 'make dtbs'.

Stephen Boyd (2):
  ARM: MSM: Add handle_irq handler for 8660 DT machine
  ARM: MSM: Add msm8660-surf.dts to Makefile.boot

 arch/arm/mach-msm/Makefile.boot   | 2 ++
 arch/arm/mach-msm/board-msm8x60.c | 1 +
 2 files changed, 3 insertions(+)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
