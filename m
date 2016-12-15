From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Thu, 15 Dec 2016 12:35:33 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Change node name for pwrseq pin on
 Olinuxino-lime2-emmc
In-Reply-To: <20161214153013.bkdm3pu3osepfnn2@lukather>
References: <20161214145724.42745-1-manu@bidouilliste.com>
 <20161214153013.bkdm3pu3osepfnn2@lukather>
Message-ID: <20161215123533.f7e2373d2a9eb113ee7b0600@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 Hi Maxime,

On Wed, 14 Dec 2016 16:30:13 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Dec 14, 2016 at 03:57:24PM +0100, Emmanuel Vadot wrote:
> > The node name for the power seq pin is mmc2 at 0 like the mmc2_pins_a one.
> > This makes the original node (mmc2_pins_a) scrapped out of the dtb and
> > result in a unusable eMMC if U-Boot didn't configured the pins to the
> > correct functions.
> > 
> > Changes since v1:
> >  * Rename the node mmc2-rst-pin
> 
> That changelog should be after the ---. Removed it and applied.
> 
> Thanks!
> Maxime

 Sorry, still kinda new at doing patches for Linux, will be more
carefull next time.
 Quick question, when you say applied, applied where exactly ? I had a
quick look at your branches on git.kernel.org didn't find anything.

 Thanks.

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
