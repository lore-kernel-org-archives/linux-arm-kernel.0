From: heiko.stuebner@bqreaders.com (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 21 Jun 2013 09:34:37 +0200
Subject: [GIT PULL] basic Rockchip support
Message-ID: <201306210934.51624.heiko.stuebner@bqreaders.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If it's not to late, please consider the following. Done on top of the needed
timer/dw_apb_timer_of branch of arm-soc.


The following changes since commit 10021488997317d1121505a7ac659124c058efed:

  clocksource: dw_apb_timer_of: use clocksource_of_init (2013-06-12 13:47:38 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.11-rockchip-basics

for you to fetch changes up to d63dc0514d56e108cc96e334ca26b538263e52a2:

  arm: add basic support for Rockchip RK3066a boards (2013-06-21 09:21:02 +0200)

----------------------------------------------------------------
Adds basic support for Rockchip Cortex-A9 SoCs.

----------------------------------------------------------------
Heiko Stuebner (3):
      arm: Add basic clocks for Rockchip rk3066a SoCs
      arm: add debug uarts for rockchip rk29xx and rk3xxx series
      arm: add basic support for Rockchip RK3066a boards

 arch/arm/Kconfig                      |    2 +
 arch/arm/Kconfig.debug                |   34 +++
 arch/arm/Makefile                     |    1 +
 arch/arm/boot/dts/rk3066a-clocks.dtsi |  299 +++++++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi        |  390 +++++++++++++++++++++++++++++++++
 arch/arm/include/debug/rockchip.S     |   42 ++++
 arch/arm/mach-rockchip/Kconfig        |   16 ++
 arch/arm/mach-rockchip/Makefile       |    1 +
 arch/arm/mach-rockchip/rockchip.c     |   52 +++++
 9 files changed, 837 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/rk3066a.dtsi
 create mode 100644 arch/arm/include/debug/rockchip.S
 create mode 100644 arch/arm/mach-rockchip/Kconfig
 create mode 100644 arch/arm/mach-rockchip/Makefile
 create mode 100644 arch/arm/mach-rockchip/rockchip.c
