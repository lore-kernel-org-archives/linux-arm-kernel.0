From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Dec 2016 13:17:26 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Change node name for pwrseq pin on
 Olinuxino-lime2-emmc
In-Reply-To: <20161215123533.f7e2373d2a9eb113ee7b0600@bidouilliste.com>
References: <20161214145724.42745-1-manu@bidouilliste.com>
 <20161214153013.bkdm3pu3osepfnn2@lukather>
 <20161215123533.f7e2373d2a9eb113ee7b0600@bidouilliste.com>
Message-ID: <20161215121726.hfrjk5kfgaifnkgq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 12:35:33PM +0100, Emmanuel Vadot wrote:
> 
>  Hi Maxime,
> 
> On Wed, 14 Dec 2016 16:30:13 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Wed, Dec 14, 2016 at 03:57:24PM +0100, Emmanuel Vadot wrote:
> > > The node name for the power seq pin is mmc2 at 0 like the mmc2_pins_a one.
> > > This makes the original node (mmc2_pins_a) scrapped out of the dtb and
> > > result in a unusable eMMC if U-Boot didn't configured the pins to the
> > > correct functions.
> > > 
> > > Changes since v1:
> > >  * Rename the node mmc2-rst-pin
> > 
> > That changelog should be after the ---. Removed it and applied.
> > 
> > Thanks!
> > Maxime
> 
>  Sorry, still kinda new at doing patches for Linux, will be more
> carefull next time.
>  Quick question, when you say applied, applied where exactly ? I had a
> quick look at your branches on git.kernel.org didn't find anything.

In general, my tree on kernel.org.

In this case, my local tree for now. We're right in the middle of the
merge window for 4.10, so in order not to pollute next and not to
confuse everyone (or rebasing a branch at some point), I just gather
the patches here. I'll publish a branch based on 4.10 as soon as
4.10-rc1 is released.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/74075136/attachment.sig>
