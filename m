From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 24 Sep 2014 21:36:33 +0800
Subject: [PATCH 0/2] Add clock binding id for rk3288
Message-ID: <1411565795-26966-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add some clock binding id for different modules
that under development and going to send upstream.

This patch also add the clock node in PD_VIDEO.


Kever Yang (2):
  clk: rockchip: add some needed clock binding id for rk3288
  clk: rockchip: use the clock id for nodes init

 drivers/clk/rockchip/clk-rk3288.c      | 79 +++++++++++++++++++---------------
 include/dt-bindings/clock/rk3288-cru.h | 38 +++++++++++++++-
 2 files changed, 82 insertions(+), 35 deletions(-)

-- 
1.9.1
