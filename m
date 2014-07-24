From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Jul 2014 16:47:05 +0200
Subject: [GIT PULL] ARM: rockchip: cpu hotplug support for rk3066 and rk3188
Message-ID: <2493373.SAC3dT5BBy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.17-rockchip-smp-hotplug

for you to fetch changes up to f54b91fdfa7a1b5603d6d00f9972765662a4e6ef:

  ARM: rockchip: Add cpu hotplug support for RK3XXX SoCs (2014-07-23 11:42:29 +0200)

----------------------------------------------------------------
CPU-Hotplug support for RK3066 and RK3188

----------------------------------------------------------------
Heiko Stuebner (1):
      ARM: rockchip: select ARMv7 compiler flags for platsmp.o

Romain Perier (1):
      ARM: rockchip: Add cpu hotplug support for RK3XXX SoCs

 arch/arm/mach-rockchip/Makefile  |  2 ++
 arch/arm/mach-rockchip/platsmp.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)
