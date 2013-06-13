From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 14 Jun 2013 00:44:15 +0200
Subject: [PATCH 0/3] ARM: S3C24XX: s3c2416 build fixes
Message-ID: <201306140044.15568.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing Tomasz' timer series I came accross some small build problems
in the new code for pinctrl and dt support on s3c24xx.

All 3 patches fix problems in the samsung tree, so should also go thru there.

Heiko Stuebner (3):
  gpio: samsung: add PINCTRL_S3C24XX to exclude options
  pinctrl: s3c24xx: use correct header for chained_irq functions
  ARM: S3C24XX: update uart addresses in s3c2416-dt auxdata

 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |    8 ++++----
 drivers/gpio/gpio-samsung.c             |    3 ++-
 drivers/pinctrl/pinctrl-s3c24xx.c       |    3 +--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.7.10.4
