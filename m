From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:01:53 +0200
Subject: [PATCH] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to
 MMC module clocks
In-Reply-To: <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
References: <20180820134013.16527-1-icenowy@aosc.io>
 <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
Message-ID: <20180905070153.a5ba6razlhdwdjde@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 01:23:54PM -0700, Stephen Boyd wrote:
> Quoting Icenowy Zheng (2018-08-20 06:40:13)
> > On the H6, the MMC module clocks are fixed in the new timing mode,
> > i.e. they do not have a bit to select the mode. These clocks have
> > a 2x divider somewhere between the clock and the MMC module.
> > 
> > To be consistent with other SoCs supporting the new timing mode,
> > we model the 2x divider as a fixed post-divider on the MMC module
> > clocks.
> > 
> > This patch adds the post-dividers to the MMC clocks, following the
> > approach on A64.
> > 
> > Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> 
> This commit doesn't exist. Did you mean:
> 
> 524353ea48
> 
> instead?

I changed it. Please also use 12-characters commit IDs, as recommended
in the kernel documentation.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/b99265f9/attachment.sig>
