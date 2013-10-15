From: heiko.stuebner@bqreaders.com (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:54:46 +0200
Subject: [PATCH 0/2] ARM: rockchip: two small fixes
Message-ID: <201310151254.46554.heiko.stuebner@bqreaders.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both fixes are not critical, so can wait for the next merge window.
One removes simple obsolete (and unused) properties and the second fixes
the TWD selection in the Kconfig, which will only become important with
the upcoming SMP support.

Heiko Stuebner (2):
  ARM: rockchip: fix wrong use of non-existent CONFIG_LOCAL_TIMERS
  ARM: rockchip: remove obsolete rockchip,config properties

 arch/arm/boot/dts/rk3066a.dtsi |   22 ----------------------
 arch/arm/mach-rockchip/Kconfig |    3 +--
 2 files changed, 1 insertion(+), 24 deletions(-)

-- 
1.7.10.4
