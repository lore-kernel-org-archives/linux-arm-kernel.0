From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 19 Oct 2016 18:06:23 -0300
Subject: [PATCH 0/4] PM / devfreq: Fix module autoload for platform drivers
Message-ID: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I noticed that module autoload won't be working in some of the defreq
platform drivers. This patch series contains the fixes for these.

Best regards,
Javier


Javier Martinez Canillas (4):
  PM / devfreq: rk3399_dmc: Fix module autoload
  PM / devfreq: exynos-nocp: Fix module autoload
  PM / devfreq: rockchip-dfi: Fix module autoload
  PM / devfreq: exynos-ppmu: Fix module autoload

 drivers/devfreq/event/exynos-nocp.c  | 1 +
 drivers/devfreq/event/exynos-ppmu.c  | 1 +
 drivers/devfreq/event/rockchip-dfi.c | 1 +
 drivers/devfreq/rk3399_dmc.c         | 1 +
 4 files changed, 4 insertions(+)

-- 
2.7.4
