From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 22 Mar 2018 09:05:49 +0100
Subject: [PATCH 08/10] drm/fourcc: Add definitions for Allwinner vendor
 and MB32 tiled format
In-Reply-To: <CAPj87rPNgga_pspx_0kTiP4itWUOL3O++2ZCiTUFfNBDGzkd0w@mail.gmail.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-9-paul.kocialkowski@bootlin.com>
 <CAPj87rPNgga_pspx_0kTiP4itWUOL3O++2ZCiTUFfNBDGzkd0w@mail.gmail.com>
Message-ID: <1521705949.1175.0.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-03-21 at 16:47 +0000, Daniel Stone wrote:
> Hi Paul,
> 
> On 21 March 2018 at 15:29, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > +/*
> > + * Allwinner "MB32" tiled format
> > + *
> > + * This is the primary layout coming out of the VPU, where pixels
> > are tiled
> > + * 32x32.
> > + */
> 
> Can you please be a bit more specific here, following the other
> examples? In particular, it should list whether the tile order is row-
> or column-major.

Yes that would definitely make sense, I'll do that in v2.

Thanks for the review!

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/27150a88/attachment.sig>
