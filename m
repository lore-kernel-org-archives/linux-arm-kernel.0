From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 25 Sep 2014 15:48:44 +0800
Subject: [PATCH v3 0/3] Add clock binding id for rk3288
Message-ID: <1411631328-14973-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add some clock binding id for different modules
that under development and going to send upstream.

This patch also add the clock node in PD_VIDEO.

Changes in v3:
- add a fix factor
- introduce a virtual node to implement the clock struct

Changes in v2:
- split into two patches of add clock node in PD_VIDEO and
  use new defined clock ID
- split out the patch

Kever Yang (3):
  clk: rockchip: add some needed clock binding id for rk3288
  clk: rockchip: use the clock id for nodes init
  clk: rockchip: add clock node in PD_VIDEO

 drivers/clk/rockchip/clk-rk3288.c      | 88 +++++++++++++++++++++-------------
 include/dt-bindings/clock/rk3288-cru.h | 38 ++++++++++++++-
 2 files changed, 91 insertions(+), 35 deletions(-)

-- 
1.9.1
