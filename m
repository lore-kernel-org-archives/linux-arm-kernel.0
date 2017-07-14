From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 14 Jul 2017 15:02:40 +0800
Subject: [PATCH v1 0/3] soc: rockchip: Modify power domain driver for rk3366
 SoC
Message-ID: <1500015763-4940-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support rk3366 SoC power domain setting.

Elaine Zhang (3):
  dt-bindings: power: add RK3366 SoCs header for power-domain
  dt-bindings: add binding for rk3366 power domains
  soc: rockchip: power-domain: add power domain support for rk3366

 .../bindings/soc/rockchip/power_domain.txt         |  3 ++
 drivers/soc/rockchip/pm_domains.c                  | 32 ++++++++++++++++++++++
 include/dt-bindings/power/rk3366-power.h           | 24 ++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3366-power.h

-- 
1.9.1
