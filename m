From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 18 Feb 2013 13:12:26 +0800
Subject: [PATCH v3 00/12] enhance DT support on gpio pxa
Message-ID: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:

v3:
* Fix the gpio irq issue on legacy platform.
* Discard irq_base & use irq domain instead in pxa_gpio_chip structure.
* Update DTS file since it's depend on latest pinctrl single driver.

v2:
* Fix the build issue without CONFIG_OF
* Append to check PINCTRL_SINGLE because of arch pxa not moved to DT
* Use bool for inverted, ed_mask, gafr variable
