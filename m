From: zhangqing@rock-chips.com (zhangqing)
Date: Mon, 11 Jan 2016 02:36:37 -0800
Subject: [PATCH v3 0/3] SoC: rockchip: support power domain for RK3368
Message-ID: <1452508600-3512-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pd id in rk3368-power.h
modify pm_domains.c to support RK3368 SoC
add RK3368 document for Rockchip power domains

zhangqing (3):
  dt-bindings: add power-domain header for RK3368 SoCs
  soc: rockchip: power-domain: Modify power domain driver for rk3368
  dt-bindings: modify document of Rockchip power domains

 .../bindings/soc/rockchip/power_domain.txt         | 21 ++++++++++++++
 drivers/soc/rockchip/pm_domains.c                  | 33 ++++++++++++++++++++++
 include/dt-bindings/power/rk3368-power.h           | 28 ++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3368-power.h

-- 
1.9.1
