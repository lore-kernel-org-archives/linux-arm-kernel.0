From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 6 Apr 2015 11:20:48 +0530
Subject: [PATCH 03/14] clkdev: get rid of redundant clk_add_alias()
 prototype in linux/clk.h
In-Reply-To: <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
Message-ID: <55221EB8.7080403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 April 2015 10:42 PM, Russell King wrote:
> clk_add_alias() is provided by clkdev, and is not part of the clk API.
> Howver, it is prototyped in two locations: linux/clkdev.h and
> linux/clk.h.  This is a mess.  Get rid of the redundant and unnecessary
> version in linux/clk.h.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-davinci/da850.c        |  1 +

For the DaVinci change:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
