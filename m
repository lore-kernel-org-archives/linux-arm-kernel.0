From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Jul 2017 21:45:22 +0200
Subject: [PATCH v3 00/10] ARM: sun8i: a83t: Add support for MMC controllers
In-Reply-To: <CAGb2v66DQ3H2Mta7h+t1P+UzSRLnMABRebeYcopaPkN0gOiwxA@mail.gmail.com>
References: <20170724135905.28855-1-wens@csie.org>
 <CAGb2v66DQ3H2Mta7h+t1P+UzSRLnMABRebeYcopaPkN0gOiwxA@mail.gmail.com>
Message-ID: <20170726194522.7d64f7c2danrknfi@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 10:09:41PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 24, 2017 at 9:58 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > Hi everyone,
> >
> > This is v3 of my MMC controller support series.
> >
> 
> [...]
> 
> > Chen-Yu Tsai (10):
> >   clk: sunxi-ng: Add interface to query or configure MMC timing modes.
> >   clk: sunxi-ng: Add MP_MMC clocks that support MMC timing modes
> >     switching
> >   clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
> >   mmc: sunxi: Support controllers that can use both old and new timings
> >   mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
> >   mmc: sunxi: Add support for A83T eMMC (MMC2)
> 
> So this series seems to be ready for inclusion, unless Ulf has further
> concerns about the clk usage.
> 
> The first mmc patch have build time dependencies on the first clk patch.
> Shall we put the clk patch on a separate immutable branch for both trees
> to pull? Or we could just merge everything through the mmc tree? I don't
> think we'll touch this part of the sunxi-ng clk driver for the remainder
> of this cycle.

I guess the easiest would be for it to go through Ulf tree, unless he
says otherwise of course :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/b8392cda/attachment.sig>
