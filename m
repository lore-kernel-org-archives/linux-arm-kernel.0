From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 11:49:48 +0200
Subject: [GIT PULL 2/4] Rockchip driver changes for 4.14
In-Reply-To: <12145142.47nS8LyXIe@phil>
References: <12145142.47nS8LyXIe@phil>
Message-ID: <2005870.SXnsRdLqkP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-drivers-1

for you to fetch changes up to bd85f4b76916f9d9d7130e58601662133399079a:

  soc: rockchip: power-domain: add power domain support for rk3366 (2017-07-20 22:42:19 +0200)

----------------------------------------------------------------
Powerdomain support for rk3366 and disabling of the automatic
jtag/sdmmc switching for rk3328.

----------------------------------------------------------------
Elaine Zhang (3):
      dt-bindings: power: add RK3366 SoCs header for power-domain
      dt-bindings: add binding for rk3366 power domains
      soc: rockchip: power-domain: add power domain support for rk3366

Heiko Stuebner (1):
      Merge branch 'v4.14-shared/pdids' into v4.14-armsoc/drivers

Shawn Lin (1):
      soc: rockchip: disable jtag switching for RK3328 Soc

 .../bindings/soc/rockchip/power_domain.txt         |  3 ++
 drivers/soc/rockchip/grf.c                         | 14 ++++++++++
 drivers/soc/rockchip/pm_domains.c                  | 32 ++++++++++++++++++++++
 include/dt-bindings/power/rk3366-power.h           | 24 ++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3366-power.h
