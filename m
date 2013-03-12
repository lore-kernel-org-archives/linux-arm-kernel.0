From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 01:08:29 +0800
Subject: [PATCH v2 00/14] add hisilicon soc support
Message-ID: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v2:
   1. Rename mach-hs to mach-hi3xxx.
   2. Remove CONFIG_MACH_HS_DT.
   3. Move sp804 dual timer driver into drivers/clocksource.
   4. Make sp804 driver to support DT. Append CLOCKSOURCE_OF_DECLARE() in sp804 driver.
   5. Update hisilicon,hi3620-clkgate & hisilicon,hi3620-clkrst property in clk-hi3xxx driver.
