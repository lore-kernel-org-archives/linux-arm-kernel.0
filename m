From: davidb@codeaurora.org (David Brown)
Date: Thu, 30 May 2013 14:06:58 -0700
Subject: Changes pulled into MSM tree
Message-ID: <20130530210658.GA13171@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes have been pulled into the msm tree for my next
pull request.  I expect to send the pull request after these sit in
next for a few days.  The changes can be seen at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git for-next

Chen Gang (1):
      arch: arm: mach-msm: using strlcpy instead of strncpy

Maxime Ripard (1):
      ARM: msm: Remove init_irq declaration in machine description

Rohit Vaswani (3):
      ARM: msm: Remove gpiomux-v2 and re-organize MSM_GPIOMUX configs
      ARM: msm: Remove unused and unmapped MSM_TLMM_BASE for 8x60
      gpio: msm: Add device tree and irqdomain support for gpio-msm-v2

Stephen Boyd (1):
      ARM: dts: msm: Fix bad register addresses

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
