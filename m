From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Apr 2016 11:18:23 +0200
Subject: [PATCH v3 03/19] clk: sunxi: Add PLL3 clock
In-Reply-To: <20160415223441.GT14441@codeaurora.org>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-4-git-send-email-maxime.ripard@free-electrons.com>
 <20160415223441.GT14441@codeaurora.org>
Message-ID: <20160419091823.GX4005@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 03:34:41PM -0700, Stephen Boyd wrote:
> On 03/23, Maxime Ripard wrote:
> > The A10 SoCs and relatives have a PLL controller to drive the PLL3 and
> > PLL7, clocked from a 3MHz oscillator, that drives the display related
> > clocks (GPU, display engine, TCON, etc.)
> > 
> > Add a driver for it.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/f8a4379f/attachment.sig>
