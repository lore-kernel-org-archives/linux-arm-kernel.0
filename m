From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Aug 2017 22:00:04 +0200
Subject: [PATCH 2/2] ARM: sunxi: add support for R40 SoC
In-Reply-To: <0809ae2d75f210b9bfee49b383f226b2@aosc.io>
References: <20170820052957.34597-1-icenowy@aosc.io>
 <20170820052957.34597-2-icenowy@aosc.io>
 <20170821093405.n4bum7j6nswnv6wr@flea.lan>
 <0809ae2d75f210b9bfee49b383f226b2@aosc.io>
Message-ID: <20170822200004.cuuj63j7am6xypdw@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 01:14:09PM +0800, icenowy at aosc.io wrote:
> ? 2017-08-21 17:34?Maxime Ripard ???
> > Hi,
> > 
> > On Sun, Aug 20, 2017 at 01:29:57PM +0800, Icenowy Zheng wrote:
> > > Allwinner R40 is a new SoC, with Quad Core Cortex-A7 and peripherals
> > > like A20.
> > > 
> > > Add support for it.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >  Documentation/arm/sunxi/README                  | 6 ++++++
> > >  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
> > >  arch/arm/mach-sunxi/sunxi.c                     | 1 +
> > >  3 files changed, 8 insertions(+)
> > > 
> > > diff --git a/Documentation/arm/sunxi/README
> > > b/Documentation/arm/sunxi/README
> > > index d7b1f016bd62..4fa836782e46 100644
> > > --- a/Documentation/arm/sunxi/README
> > > +++ b/Documentation/arm/sunxi/README
> > > @@ -75,6 +75,12 @@ SunXi family
> > >          + Datasheet
> > > http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
> > > 
> > > +      - Allwinner R40 (sun8i)
> > > +        + Datasheet
> > > +
> > > https://github.com/tinalinux/docs/raw/r40-v1.y/R40_Datasheet_V1.0.pdf
> > > +        + User Manual
> > > +          https://github.com/tinalinux/docs/raw/r40-v1.y/Allwinner_R40_User_Manual_V1.0.pdf
> > > +
> > 
> > Please sort it by alphabetical order.
> 
> I prefer to sort it by the wafer ID (the number after w in the
> official ID).
> 
> The current document can be explained to follow the alphabetical
> order or the wafer ID.

You should know who your audience is. Whoever is going to end up here
to have a list of the SoC names and their datasheet is very likely to
not know by heart the wafer IDs, while anyone that can read knows the
alphabet.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/33ebde9f/attachment.sig>
