From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 22:31:56 +0200
Subject: [PATCH v3 5/6] clk: sunxi-ng: Add A31/A31s clocks
In-Reply-To: <20160825062200.17206-6-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
 <20160825062200.17206-6-wens@csie.org>
Message-ID: <20160825203156.GF32598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 02:21:59PM +0800, Chen-Yu Tsai wrote:
> Add a new style driver for the clock control unit in Allwinner A31/A31s.
> 
> A few clocks are still missing:
> 
>     - MIPI PLL's HDMI mode support
>     - EMAC clock
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/3dcbca19/attachment.sig>
