From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu,  3 Mar 2016 16:03:47 +0800
Subject: [PATCH v5 0/6] rockchip: power-domain: fix pm domain for support
 RK3399 SoC
Message-ID: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix some idle handling
support sub-power domain
add rk3399-power.h
modify document for RK3399 Soc
modify power domain for RK3399 SoC

Changes in v5:
[PATCH v5 3/6]:fix up some coding style
[PATCH v5 5/6]:fix up some coding style

Elaine Zhang (6):
  rockchip: power-domain: make idle handling optional
  power-domain: allow domains only handling idle requests
  rockchip: power-domain: add support for sub-power domains
  dt/bindings: power: add RK3399 SoCs header for power-domain
  dt/bindings: rockchip: modify document of Rockchip power domains
  rockchip: power-domain: Modify power domain driver for rk3399

 .../bindings/soc/rockchip/power_domain.txt         |  37 ++++++
 drivers/soc/rockchip/pm_domains.c                  | 139 ++++++++++++++++++++-
 include/dt-bindings/power/rk3399-power.h           |  53 ++++++++
 3 files changed, 224 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3399-power.h

-- 
1.9.1
