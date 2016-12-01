From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Dec 2016 10:42:18 +0100
Subject: [PATCH v7 0/8] drm: sun8i: Add DE2 HDMI video support
In-Reply-To: <2084988.kISO4Quil7@avalon>
References: <cover.1480414715.git.moinejf@free.fr> <2039137.LtCOH6bs2I@avalon>
 <20161201091313.th7nucjmvtuolqza@lukather>
 <2084988.kISO4Quil7@avalon>
Message-ID: <20161201094218.6snkyrsxex3hpwwi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 11:19:56AM +0200, Laurent Pinchart wrote:
> Hi Maxime,
> 
> On Thursday 01 Dec 2016 10:13:13 Maxime Ripard wrote:
> > On Wed, Nov 30, 2016 at 12:12:55PM +0200, Laurent Pinchart wrote:
> > >> More, it is not sure that the bridge/DW code would work with Allwinner's
> > >> SoCs.
> > > 
> > > If it doesn't work and can't be made to work in a non-invasive way they it
> > > should certainly not be used :-)
> > 
> > Even if the register layout is completely scrambled, as long as the
> > bits themselves aren't (and by comparing the two drivers it looks like
> > they haven't changed), you can easily deal with that using the
> > regmap_fields, with the two implementations (the original one and the
> > scrambled one) providing their register map that way, and the driver
> > code using whatever has been provided.
> 
> Looking at https://linux-sunxi.org/DWC_HDMI_Controller#DWC_HDMI_Controller it 
> seems that an address remapping function could be used.

Even better.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/79cf80f8/attachment.sig>
