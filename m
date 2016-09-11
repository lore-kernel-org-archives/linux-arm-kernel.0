From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Sep 2016 14:14:36 +0200
Subject: [PATCH 0/6] constify gpio_chip structures
Message-ID: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constify gpio_chip structures

---

 drivers/gpio/gpio-arizona.c                   |    2 +-
 drivers/gpio/gpio-bcm-kona.c                  |    2 +-
 drivers/gpio/gpio-da9052.c                    |    2 +-
 drivers/gpio/gpio-da9055.c                    |    2 +-
 drivers/gpio/gpio-it87.c                      |    2 +-
 drivers/gpio/gpio-lp873x.c                    |    2 +-
 drivers/gpio/gpio-lpc18xx.c                   |    2 +-
 drivers/gpio/gpio-pisosr.c                    |    2 +-
 drivers/gpio/gpio-sch.c                       |    2 +-
 drivers/gpio/gpio-stmpe.c                     |    2 +-
 drivers/gpio/gpio-tc3589x.c                   |    2 +-
 drivers/gpio/gpio-tpic2810.c                  |    2 +-
 drivers/gpio/gpio-tps65086.c                  |    2 +-
 drivers/gpio/gpio-tps65218.c                  |    2 +-
 drivers/gpio/gpio-tps65912.c                  |    2 +-
 drivers/gpio/gpio-ts4900.c                    |    2 +-
 drivers/gpio/gpio-twl4030.c                   |    2 +-
 drivers/gpio/gpio-wm831x.c                    |    2 +-
 drivers/gpio/gpio-wm8350.c                    |    2 +-
 drivers/gpio/gpio-wm8994.c                    |    2 +-
 drivers/mfd/sm501.c                           |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c         |    2 +-
 sound/soc/codecs/rt5677.c                     |    2 +-
 sound/soc/codecs/wm5100.c                     |    2 +-
 sound/soc/codecs/wm8903.c                     |    2 +-
 sound/soc/codecs/wm8962.c                     |    2 +-
 sound/soc/codecs/wm8996.c                     |    2 +-
 sound/soc/soc-ac97.c                          |    2 +-
 29 files changed, 29 insertions(+), 29 deletions(-)
