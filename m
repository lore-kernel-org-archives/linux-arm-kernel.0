From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 14:13:57 +0200
Subject: [PATCH] ARM64: kernel: compiling issue: need define readq and
 writeq for driver module using.
In-Reply-To: <51712975.8030104@asianux.com>
References: <51712975.8030104@asianux.com>
Message-ID: <201304191413.57424.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Chen Gang wrote:
>   when compiling with allmodconfig, CONFIG_64BIT=y
>     the file drivers/base/regmap/regmap-mmio.c will use readq and writeq.
> 
>   so we need implement these functions.
> 
> BTW:
>   the coding style can not pass ./scripts/checkpatch.pl.
>   it seems better to provide additional patch for beautifying code.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
