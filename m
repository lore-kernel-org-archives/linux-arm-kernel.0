From: zhangqing@rock-chips.com (zhangqing)
Date: Fri,  8 Jan 2016 10:37:39 -0800
Subject: [PATCH v2 0/2] SoC: rockchip: support power domain for RK3368
Message-ID: <1452278261-16864-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pd id in rk3368-power.h
modify pm_domains.c to support RK3368 SoC.

zhangqing (2):
  dt-bindings: add power-domain header for RK3368 SoCs
  soc: rockchip: power-domain: Modify power domain driver for rk3368

 drivers/soc/rockchip/pm_domains.c        | 33 ++++++++++++++++++++++++++++++++
 include/dt-bindings/power/rk3368-power.h | 28 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3368-power.h

-- 
1.9.1
