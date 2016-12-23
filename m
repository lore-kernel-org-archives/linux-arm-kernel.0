From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 23 Dec 2016 11:47:49 +0800
Subject: [PATCH v1 0/3] soc: rockchip: power-domain: support RK3328 SoC
Message-ID: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elaine Zhang (3):
  dt/bindings: power: add RK3328 SoCs header for idle-request
  dt-bindings: add binding for rk3328 power domains
  soc: rockchip: power-domain: Modify power domain driver for rk3328

 .../bindings/soc/rockchip/power_domain.txt         |  3 ++
 drivers/soc/rockchip/pm_domains.c                  | 63 +++++++++++++++++++---
 include/dt-bindings/power/rk3328-power.h           | 18 +++++++
 3 files changed, 78 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3328-power.h

-- 
1.9.1
