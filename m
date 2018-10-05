From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 5 Oct 2018 16:37:50 +0200
Subject: [PATCH] [v2] ARM: omap1: add nand_chip declaration
In-Reply-To: <20180926142029.619397-1-arnd@arndb.de>
References: <20180926142029.619397-1-arnd@arndb.de>
Message-ID: <20181005163750.01fddf10@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 16:20:16 +0200:

> Recent MTD changes caused a minor build regression on OMAP1:
> 
> In file included from arch/arm/mach-omap1/devices.c:31:
> arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: remove unused linux/mtd/mtd.h inclusion
> ---

Also squashed in nand/next with the failing commit.

Thanks,
Miqu?l
