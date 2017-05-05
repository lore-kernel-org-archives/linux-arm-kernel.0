From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 May 2017 14:30:35 +0200
Subject: [linux-sunxi] [PATCH v6 11/13] ARM: dts: sun8i: add DE2 nodes
 for V3s SoC
In-Reply-To: <8ad5de02ffc13348dfc71e9ec203205c@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-12-icenowy@aosc.io>
 <CAGb2v67uE2iuP+wrL2t0fSMY8C1qnX=pYru7pZGX+0WhC_z2EA@mail.gmail.com>
 <8ad5de02ffc13348dfc71e9ec203205c@aosc.io>
Message-ID: <20170505123035.pwh3idz73ujrd3hx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 04:53:43PM +0800, icenowy at aosc.io wrote:
> > > +               de2_clocks: clock at 1000000 {
> > > +                       compatible = "allwinner,sun50i-h5-de2-clk";
> > 
> > I am a bit skeptical about this. Since the V3S only has one mixer, do
> > the clocks
> > for the second one even exist?
> 
> It's described in the de_clock.c in the BSP source code, and in hardware
> these bits can be really set (although without clock output).
> 
> So I use this compatible which has still the extra clocks.

If it's not usable, then it shouldn't be in the code, it's basically
dead code.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170505/5c327a65/attachment.sig>
