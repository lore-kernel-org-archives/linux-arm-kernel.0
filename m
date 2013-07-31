From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:30:59 -0700
Subject: [PATCH 00/18] Convert arm sched_clock users to sched_clock_register()
In-Reply-To: <51F80B09.8060509@linaro.org>
Message-ID: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset converts all the arm users to sched_clock_register(). It
is based on the pull request that this is in reply to. Platform
maintainers, please ack/review.

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

Stephen Boyd (18):
  ARM: timer-sp: Switch to sched_clock_register()
  ARM: clps711x: Switch to sched_clock_register()
  ARM: davinci: Switch to sched_clock_register()
  ARM: imx: Switch to sched_clock_register()
  ARM: integrator: Switch to sched_clock_register()
  ARM: IXP4xx: Switch to sched_clock_register()
  ARM: mmp: Switch to sched_clock_register()
  ARM: msm: Switch to sched_clock_register()
  ARM: OMAP1: Switch to sched_clock_register()
  ARM: OMAP2+: Switch to sched_clock_register()
  ARM: pxa: Switch to sched_clock_register()
  ARM: sa1100: Switch to sched_clock_register()
  ARM: u300: Switch to sched_clock_register()
  ARM: iop: Switch to sched_clock_register()
  ARM: OMAP: Switch to sched_clock_register()
  ARM: orion: Switch to sched_clock_register()
  ARM: SAMSUNG: Switch to sched_clock_register()
  ARM: versatile: Switch to sched_clock_register()

 arch/arm/common/timer-sp.c               | 4 ++--
 arch/arm/mach-clps711x/common.c          | 4 ++--
 arch/arm/mach-davinci/time.c             | 4 ++--
 arch/arm/mach-imx/time.c                 | 4 ++--
 arch/arm/mach-integrator/integrator_ap.c | 4 ++--
 arch/arm/mach-ixp4xx/common.c            | 4 ++--
 arch/arm/mach-mmp/time.c                 | 4 ++--
 arch/arm/mach-msm/timer.c                | 4 ++--
 arch/arm/mach-omap1/time.c               | 4 ++--
 arch/arm/mach-omap2/timer.c              | 4 ++--
 arch/arm/mach-pxa/time.c                 | 4 ++--
 arch/arm/mach-sa1100/time.c              | 4 ++--
 arch/arm/mach-u300/timer.c               | 4 ++--
 arch/arm/plat-iop/time.c                 | 4 ++--
 arch/arm/plat-omap/counter_32k.c         | 4 ++--
 arch/arm/plat-orion/time.c               | 4 ++--
 arch/arm/plat-samsung/samsung-time.c     | 4 ++--
 arch/arm/plat-versatile/sched-clock.c    | 4 ++--
 18 files changed, 36 insertions(+), 36 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
