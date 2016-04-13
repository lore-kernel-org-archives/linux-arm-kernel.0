From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 13 Apr 2016 11:21:48 +0200
Subject: [GIT PULL 1/4] Rockchip driver updates for v4.7 - part1
In-Reply-To: <2557248.QNyQ7BnmgO@diego>
References: <2557248.QNyQ7BnmgO@diego>
Message-ID: <16791666.09OigPW6oN@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.7-rockchip-drivers-1

for you to fetch changes up to 4506697d9f8537a8d33e9e002f8efceb32d10757:

  soc: rockchip: power-domain: check the existing of regmap (2016-04-12 03:28:08 +0200)

----------------------------------------------------------------
Rockchip soc-specific driver changes containing support for the
rk3399 powerdomains and necessary infrastructure changes to
accomodate them - like supporting nested powerdomains here.

----------------------------------------------------------------
Elaine Zhang (6):
      soc: rockchip: power-domain: make idle handling optional
      soc: rockchip: power-domain: allow domains only handling idle requests
      soc: rockchip: power-domain: add support for sub-power domains
      dt-bindings: add power-domain header for RK3399 SoCs
      dt-bindings: add binding for rk3399 power domains
      soc: rockchip: power-domain: Modify power domain driver for rk3399

Heiko Stuebner (1):
      Merge branch 'v4.7-shared/pdids' into v4.7-armsoc/drivers

Shawn Lin (1):
      soc: rockchip: power-domain: check the existing of regmap

 .../bindings/soc/rockchip/power_domain.txt         |  37 ++++++
 drivers/soc/rockchip/pm_domains.c                  | 142 ++++++++++++++++++++-
 include/dt-bindings/power/rk3399-power.h           |  53 ++++++++
 3 files changed, 227 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3399-power.h
