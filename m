From: paweljarosz3691@gmail.com (=?utf-8?B?UGF3ZcWC?= Jarosz)
Date: Fri, 14 Oct 2016 14:16:21 +0200
Subject: [PATCH v2 0/2] Assign RK3066 clocks at boot time
Message-ID: <cover.1476447057.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset sets rk3066 PLL, CPU and PERI clocks while kernel init.

Pawe? Jarosz (2):
  clk: rockchip: Add bindings for cpu and peri clocks on rk3066
  ARM: dts: rockchip: initialize rk3066 PLL clock rate

 arch/arm/boot/dts/rk3066a.dtsi                |  9 +++++++++
 drivers/clk/rockchip/clk-rk3188.c             | 12 ++++++------
 include/dt-bindings/clock/rk3188-cru-common.h |  8 +++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.7.4
