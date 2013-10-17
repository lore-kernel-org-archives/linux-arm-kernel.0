From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 17 Oct 2013 21:36:04 +0200
Subject: [GIT PULL] Uncritical Rockchip fixes for 3.13
Message-ID: <201310172136.04553.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.13-rockchip-fixes

for you to fetch changes up to 1b6dc1e478c85e6028ce3a918d484ecbcd52173e:

  ARM: rockchip: remove obsolete rockchip,config properties (2013-10-14 21:01:53 +0200)

----------------------------------------------------------------
Romoval of obsolete (never used) dt properties
and fix for the selection of the TWD.

----------------------------------------------------------------
Heiko Stuebner (2):
      ARM: rockchip: fix wrong use of non-existent CONFIG_LOCAL_TIMERS
      ARM: rockchip: remove obsolete rockchip,config properties

 arch/arm/boot/dts/rk3066a.dtsi |   22 ----------------------
 arch/arm/mach-rockchip/Kconfig |    3 +--
 2 files changed, 1 insertion(+), 24 deletions(-)
