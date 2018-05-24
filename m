From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 May 2018 15:20:54 +0200
Subject: [GIT PULL] Rockchip driver updates for 4.18 round 2
Message-ID: <2574457.1saVLptjF6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin Olof,

please find below a second pull request for Rockchip-specific drivers,
adding power-domain support for some more socs on top of the
previous git tag.


If it looks ok, please pull
Heiko

The following changes since commit 9e59c5f66c624b43c766a9fe3b2430e0e976bf0e:

  soc: rockchip: power-domain: Fix wrong value when power up pd with writemask (2018-05-14 11:53:26 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-drivers-2

for you to fetch changes up to 9bdf401bf49eddba98ae36f7243b888d43496bd6:

  soc: rockchip: power-domain: add power domain support for px30 (2018-05-23 20:47:57 +0200)

----------------------------------------------------------------
Power-domain support for Rockchip socs px30, rk3128, rk3228 and rk3036.

----------------------------------------------------------------
Caesar Wang (3):
      dt-bindings: power: add RK3036 SoCs header for power-domain
      dt-bindings: power: add binding for rk3036 power domains
      soc: rockchip: power-domain: add power domain support for rk3036

Elaine Zhang (6):
      dt-bindings: power: add RK3128 SoCs header for power-domain
      dt-bindings: power: add binding for rk3128 power domains
      soc: rockchip: power-domain: add power domain support for rk3128
      dt-bindings: power: add RK3228 SoCs header for power-domain
      dt-bindings: power: add binding for rk3228 power domains
      soc: rockchip: power-domain: add power domain support for rk3228

Finley Xiao (3):
      dt-bindings: power: add PX30 SoCs header for power-domain
      dt-bindings: power: add binding for px30 power domains
      soc: rockchip: power-domain: add power domain support for px30

 .../bindings/soc/rockchip/power_domain.txt         |  12 +++
 drivers/soc/rockchip/pm_domains.c                  | 115 +++++++++++++++++++++
 include/dt-bindings/power/px30-power.h             |  27 +++++
 include/dt-bindings/power/rk3036-power.h           |  13 +++
 include/dt-bindings/power/rk3128-power.h           |  14 +++
 include/dt-bindings/power/rk3228-power.h           |  21 ++++
 6 files changed, 202 insertions(+)
 create mode 100644 include/dt-bindings/power/px30-power.h
 create mode 100644 include/dt-bindings/power/rk3036-power.h
 create mode 100644 include/dt-bindings/power/rk3128-power.h
 create mode 100644 include/dt-bindings/power/rk3228-power.h
