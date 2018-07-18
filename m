From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 18 Jul 2018 17:23:41 +0200
Subject: [PATCH v2] drm/sun4i: sun4i: Introduce a quirk for lowest plane
 alpha support
In-Reply-To: <76279f0a265bfbe509074fcff3156a437e7091dd.camel@bootlin.com>
References: <20180718092948.15334-1-paul.kocialkowski@bootlin.com>
 <76279f0a265bfbe509074fcff3156a437e7091dd.camel@bootlin.com>
Message-ID: <20180718152341.zr32w5cjtpfec4xe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 11:35:23AM +0200, Paul Kocialkowski wrote:
> On Wed, 2018-07-18 at 11:29 +0200, Paul Kocialkowski wrote:
> > Not all sunxi platforms with the first version of the Display Engine
> > support an alpha component on the plane with the lowest z position
> > (as in: lowest z-pos), that gets blended with the background color.
> > 
> > In particular, the A13 is known to have this limitation. However, it was
> > recently discovered that the A20 and A33 are capable of having alpha on
> > their lowest plane.
> > 
> > Thus, this introduces a specific quirk to indicate such support,
> > per-platform. Since this was not tested on sun4i and sun6i platforms, a
> > conservative approach is kept and this feature is not supported.
> 
> Woops, I forgot to include PATCH 1/2 from v1, which did not change.
> 
> Would it be preferable for me to send v2 again (and maybe call it v3)
> for convenience?

Yeah, resend it, and call it v2 resend (explaining why a resend was
needed).

Maxime


-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180718/bfd9b33d/attachment.sig>
