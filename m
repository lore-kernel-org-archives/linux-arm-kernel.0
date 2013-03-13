From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 13:05:31 +0800
Subject: [PATCH v3 00/11] add hisilicon SoC support
Message-ID: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v3:
   1. Replace to call hs_init_clocks() in hi3xxx.c by of_clk_init().
   2. Add CLK_OF_DECLARE() in clk-hi3xxx driver.
   3. Add "select USE_OF" for CONFIG_CLKSRC_OF configuration. So drop CONFIG_OF in sp804 driver.
   4. Move readme file into driver patch.
   5. Append "arm,integrator-timer" for sp804 match table.
v2:
   1. Rename mach-hs to mach-hi3xxx.
   2. Remove CONFIG_MACH_HS_DT.
   3. Move sp804 dual timer driver into drivers/clocksource.
   4. Make sp804 driver to support DT. Append CLOCKSOURCE_OF_DECLARE() in sp804 driver.
   5. Update hisilicon,hi3620-clkgate & hisilicon,hi3620-clkrst property in clk-hi3xxx driver.
