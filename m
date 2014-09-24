From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 24 Sep 2014 23:33:19 +0800
Subject: [PATCH v2 0/3] Add clock binding id for rk3288
Message-ID: <1411572802-22042-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add some clock binding id for different modules
that under development and going to send upstream.

This patch also add the clock node in PD_VIDEO.

Changes in v2:
- split into two patches of add clock node in PD_VIDEO and
  use new defined clock ID

Kever Yang (3):
  clk: rockchip: add some needed clock binding id for rk3288
  clk: rockchip: use the clock id for nodes init
  clk: rockchip: add clock node in PD_VIDEO

 drivers/clk/rockchip/clk-rk3288.c      | 79 +++++++++++++++++++---------------
 include/dt-bindings/clock/rk3288-cru.h | 38 +++++++++++++++-
 2 files changed, 82 insertions(+), 35 deletions(-)

-- 
1.9.1
