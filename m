From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 23:20:00 +0200
Subject: [PATCH 0/2] clk: add of_clk_provider stubs to enable clk-si5351
 on non OF
In-Reply-To: <1367369910-20402-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367369910-20402-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201305022320.00769.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 May 2013, Sebastian Hesselbarth wrote:
> 
> Yesterday 02:58:27
> Enabling drivers that provide clocks on DT on platforms that don't have
> CONFIG_OF set fails due to compilation errors. This patch set first adds
> some stubs for of_clk_provider functions if CONFIG_OF is not set. Second
> it allows those platforms to build and use clk-si5351 i2c clock driver
> by removing the dependency on CONFIG_OF.
> 
> The above approach has been suggested by Arnd Bergmann and replaces the
> corresponding Kconfig patch for clk-si5351 posted earlier. It has been
> compile tested with allmodconfig on x86_64 for post v3.9.
> 
> Sebastian Hesselbarth (2):
>   clk: add non CONFIG_OF routines for clk-provider
>   clk: si5351: Allow to build without CONFIG_OF
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
