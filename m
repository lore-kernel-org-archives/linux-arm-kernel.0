From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Feb 2016 10:44:40 +0100
Subject: [PATCH 0/2] ARM: Make reset_control_ops const
Message-ID: <1456393482-26318-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 203d4f347d86 ("reset: Make reset_control_ops const") marked
the ops pointer in struct reset_controller_dev as const, these structs
can be made const, too. The commit is currently sitting in the
arm-soc/for-next branch.

regards
Philipp

Philipp Zabel (2):
  ARM: imx: Make reset_control_ops const
  ARM: sirf: Make reset_control_ops const

 arch/arm/mach-imx/src.c     | 2 +-
 arch/arm/mach-prima2/rstc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.0
