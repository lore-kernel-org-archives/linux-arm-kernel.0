From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Nov 2012 11:30:56 -0700
Subject: [PATCH V3 00/11] ARM: delete struct sys_timer
Message-ID: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Russell, I'm mainly reposting this to see if you have any comments or
opinion, in particular on the core ARM changes.

The aim of this series is to remove ARM's struct sys_timer. As a pre-
cursor, this requires a little re-arrangement of arch_gettimeoffset and
associated changes to other architectures.

The full series can be found in git at:
git://nv-tegra.nvidia.com/user/swarren/linux-2.6 arm_timer_rework

This is based on next-20121115. The plan is to rebase it onto 3.8-rc1
once it is released, and pull this series into arm-soc.git as a baseline
for any future SoC additions.

Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-cris-kernel at axis.com
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joshua Thompson <funaho@jurai.org>
Cc: Sam Creasey <sammy@sammy.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
