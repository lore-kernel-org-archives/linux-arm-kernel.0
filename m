From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Sep 2018 07:59:32 -0700
Subject: [PATCH] [v2] ARM: omap1: add nand_chip declaration
In-Reply-To: <20180926142029.619397-1-arnd@arndb.de>
References: <20180926142029.619397-1-arnd@arndb.de>
Message-ID: <20180926145932.GR5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [180926 14:26]:
> Recent MTD changes caused a minor build regression on OMAP1:
> 
> In file included from arch/arm/mach-omap1/devices.c:31:
> arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: remove unused linux/mtd/mtd.h inclusion

Acked-by: Tony Lindgren <tony@atomide.com>
