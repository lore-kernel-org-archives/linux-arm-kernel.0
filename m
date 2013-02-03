From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 18:15:41 +0800
Subject: [PATCH v2 00/10] rework pxa gpio driver for pinctrl
Message-ID: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:

v2:
* Fix the build issue without CONFIG_OF
* Append to check PINCTRL_SINGLE because of arch pxa not moved to DT
* Use bool for inverted, ed_mask, gafr variable
