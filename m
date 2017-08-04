From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Fri, 4 Aug 2017 23:08:58 +0200
Subject: [PATCH] mtd: nand: Rename nand.h into rawnand.h
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170804230858.7c65e7e53fed824d96ea40c5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On Fri,  4 Aug 2017 17:29:10 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Peter Pan <peterpandong@micron.com>

[...]

>  arch/arm/mach-ep93xx/snappercl15.c              | 2 +-
>  arch/arm/mach-ep93xx/ts72xx.c                   | 2 +-

For mach-ep93xx
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

-- 
Alexander Sverdlin.
