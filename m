From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Mar 2012 16:22:57 +0800
Subject: [PATCH 0/2] improve imx6q arm_clk set rate
Message-ID: <1331713379-8437-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_clk rate changing should also change pll1 rate.

Richard Zhao (2):
  ARM: imx6q: add pll round_rate support
  ARM: imx6q: change pll1 rate when change arm_clk rate

 arch/arm/mach-imx/clock-imx6q.c |  161 +++++++++++++++++++++++++++++++++++---
 1 files changed, 148 insertions(+), 13 deletions(-)

-- 
1.7.5.4
