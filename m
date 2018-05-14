From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 14 May 2018 11:27:35 +0800
Subject: [PATCH v2 00/13] add power domain support for Rockchip Socs
Message-ID: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add power domain support for RK3036/RK3128/RK3228/PX30 Soc.
fix up the wrong value when set power domain up.

Change in V2:
Fix up the commit message description and Assign author.

Caesar Wang (3):
  dt-bindings: power: add RK3036 SoCs header for power-domain
  dt-bindings: add binding for rk3036 power domains
  Soc: rockchip: power-domain: add power domain support for rk3036

Elaine Zhang (6):
  dt-bindings: power: add RK3128 SoCs header for power-domain
  dt-bindings: add binding for rk3128 power domains
  soc: rockchip: power-domain: add power domain support for rk3128
  dt-bindings: power: add RK3228 SoCs header for power-domain
  dt-bindings: add binding for rk3228 power domains
  soc: rockchip: power-domain: add power domain support for rk3228

Finley Xiao (4):
  soc: rockchip: power-domain: Fix wrong value when power up pd
  dt-bindings: power: add PX30 SoCs header for power-domain
  dt-bindings: add binding for px30 power domains
  soc: rockchip: power-domain: add power domain support for px30

 .../bindings/soc/rockchip/power_domain.txt         |  12 +++
 drivers/soc/rockchip/pm_domains.c                  | 116 ++++++++++++++++++++-
 include/dt-bindings/power/px30-power.h             |  32 ++++++
 include/dt-bindings/power/rk3036-power.h           |  27 +++++
 include/dt-bindings/power/rk3128-power.h           |  28 +++++
 include/dt-bindings/power/rk3228-power.h           |  26 +++++
 6 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/px30-power.h
 create mode 100644 include/dt-bindings/power/rk3036-power.h
 create mode 100644 include/dt-bindings/power/rk3128-power.h
 create mode 100644 include/dt-bindings/power/rk3228-power.h

-- 
1.9.1
