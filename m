From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 25 Feb 2016 10:12:11 +0800
Subject: [PATCH v3 0/6] rockchip: power-domain: fix pm domain for support
 RK3399 SoC
Message-ID: <1456366337-10808-1-git-send-email-zhangqing@rock-chips.com>
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

 .../bindings/soc/rockchip/power_domain.txt         |  39 ++++++
 drivers/soc/rockchip/pm_domains.c                  | 148 +++++++++++++++++++--
 include/dt-bindings/power/rk3399-power.h           |  53 ++++++++
 3 files changed, 230 insertions(+), 10 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3399-power.h

-- 
1.9.1
