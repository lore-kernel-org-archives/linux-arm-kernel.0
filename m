From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 11:06:06 +0100
Subject: [GIT PULL 1/3] Rockchip driver updates for 4.21
Message-ID: <49803144.2ZsBJmaiIN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin Olof,

please find below and in the replies the first round of Rockchip pull
requests. I guess the most notable change is the addition of Gru-Scarlet
devicetree which - judging by the "silence" in the ChromeOS gerrit - may
conclude the series of rk3399-based ChromeOS devices.

Other than that there are smaller improvements all around,
so please pull.


Thanks
Heiko


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.21-rockchip-drivers-1

for you to fetch changes up to 24869610e867e9791f0fdab70ff60f246299b859:

  soc: rockchip: power-domain: add rk3066 powerdomains (2018-11-06 14:13:32 +0100)

----------------------------------------------------------------
Powerdomain support for rk3066 and rk3188.

----------------------------------------------------------------
Heiko Stuebner (6):
      dt-bindings: add power-domain header for RK3188 SoCs
      dt-bindings: add power-domain header for RK3066 SoCs
      dt-bindings: add compatibles for rk3066/rk3188 power controllers
      Merge branch 'v4.21-shared/pdids' into v4.21-armsoc/drivers
      soc: rockchip: power-domain: add rk3188 powerdomains
      soc: rockchip: power-domain: add rk3066 powerdomains

 .../bindings/soc/rockchip/power_domain.txt         |  4 ++
 drivers/soc/rockchip/pm_domains.c                  | 48 ++++++++++++++++++++++
 include/dt-bindings/power/rk3066-power.h           | 22 ++++++++++
 include/dt-bindings/power/rk3188-power.h           | 24 +++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3066-power.h
 create mode 100644 include/dt-bindings/power/rk3188-power.h
