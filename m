From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 20 Feb 2013 00:22:17 +0800
Subject: [PATCH v4 00/11] enhance DT support on gpio pxa
Message-ID: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:

v4:
* Re-oragnize these patches.
* Append document for new properties binding.
* Discard the full support on irq domain. It will be appended in other
  series.

v3:
* Fix the gpio irq issue on legacy platform.
* Discard irq_base & use irq domain instead in pxa_gpio_chip structure.
* Update DTS file since it's depend on latest pinctrl single driver.

v2:
* Fix the build issue without CONFIG_OF
* Append to check PINCTRL_SINGLE because of arch pxa not moved to DT
* Use bool for inverted, ed_mask, gafr variable
