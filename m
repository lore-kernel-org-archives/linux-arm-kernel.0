From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 May 2017 21:58:27 +0200
Subject: [PATCH v2 0/6] clk: sunxi-ng: Add support for A83T's PRCM
In-Reply-To: <20170531075824.657-1-wens@csie.org>
References: <20170531075824.657-1-wens@csie.org>
Message-ID: <20170531195827.kcbkwf5k2mh4q4re@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 03:58:18PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is the remaining parts of my A83T PRCM support series, along with
> changes requested by Maxime.
> 
> Patch 1 updates the device tree bindings for the PRCM, adding pll-periph
> to the list of required clocks
> 
> Patch 2 adds a device node for the PRCM on the A83T SoC, updated from v1
> to include the pll-periph clock.
> 
> Patch 3 exports the PLL_PERIPH0 clock from the CCU on the H3/H5, for
> consumption by the PRCM.
> 
> Patch 4 adds the pll-periph clock to the PRCM device node on the H3/H5.
> 
> Patch 5 / 6 are the same as 3 / 4, but for the A64.

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170531/c6714919/attachment.sig>
