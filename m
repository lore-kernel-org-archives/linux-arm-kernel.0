From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 18 Feb 2016 11:07:12 +0800
Subject: [PATCH v2 0/6] rockchip: power-domain: fix pm domain for support
 RK3399 SoC
Message-ID: <1455764838-12928-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix some idle handling
support sub-power domain
add rk3399-power.h
modify power domain for RK3399 SoC
modify document for RK3399 Soc

Elaine Zhang (6):
  rockchip: power-domain: make idle handling optional
  rockchip: power-domain: allow domains only handling idle requests
  rockchip: power-domain: add support for sub-power domains
  dt/bindings: power: add RK3399 SoCs header for power-domain
  rockchip: power-domain: Modify power domain driver for rk3399
  dt/bindings: rockchip: modify document of Rockchip power domains

 .../bindings/soc/rockchip/power_domain.txt         |  21 ++++
 drivers/soc/rockchip/pm_domains.c                  | 131 ++++++++++++++++++++-
 include/dt-bindings/power/rk3399-power.h           |  53 +++++++++
 3 files changed, 200 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3399-power.h

-- 
1.9.1
