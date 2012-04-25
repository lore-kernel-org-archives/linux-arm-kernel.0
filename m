From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 14:38:28 +0200
Subject: announcing the clk-next branch
In-Reply-To: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
Message-ID: <20120425123828.GC3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 06:32:20PM -0700, Turquette, Mike wrote:
> Hi all,
> 
> The clock patches that I have signed-off on and picked from the list
> are all rebased on top of 3.4-rc4.  They can be found here:
> 
> git://git.linaro.org/people/mturquette/linux.git clk-next

Thanks Mike!

> 
> If the branch is missing anything that I have ACK'd then please let me know.

You haven't acked it, but for i.MX I need two patches from Viresh I'd
like to base on:

[PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
[PATCH V3 2/8] clk: add a fixed factor clock

Also I need the patch implementing managed clk_get which currently sits
in Russells tree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
