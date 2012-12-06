From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Dec 2012 10:50:57 +0100
Subject: [GIT PULL] Various fixes for sunxi in 3.8
Message-ID: <1354787457-29172-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please consider pulling these two patches that fixes array non-null terminated
in the sunxi drivers.

Thanks,

Maxime

The following changes since commit 67bea88dd842deb3ed8327ad101970dbd615ddcb:

  ARM: sunxi: Add sunxi restart function via onchip watchdog (2012-11-21 09:25:25 +0100)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-fixes-for-3.8

for you to fetch changes up to ff33657288bf1e62078bc97b87c358f5a1f15844:

  irqchip: irq-sunxi: Add terminating entry for sunxi_irq_dt_ids (2012-12-03 21:17:00 +0100)

----------------------------------------------------------------
Fixes in sunXi related drivers for 3.8

----------------------------------------------------------------
Axel Lin (2):
      clocksource: sunxi_timer: Add terminating entry for sunxi_timer_dt_ids
      irqchip: irq-sunxi: Add terminating entry for sunxi_irq_dt_ids

 drivers/clocksource/sunxi_timer.c |    1 +
 drivers/irqchip/irq-sunxi.c       |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
