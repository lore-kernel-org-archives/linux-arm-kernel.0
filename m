From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 16:46:10 +0100
Subject: [PATCH v2 00/18] drm/sun4i: Add A83t LVDS support
In-Reply-To: <2681268.ePd4u43rOS@jernej-laptop>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
 <2681268.ePd4u43rOS@jernej-laptop>
Message-ID: <20171128154610.62mnmaqkvaxksggy@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

On Mon, Nov 27, 2017 at 05:20:52PM +0100, Jernej ?krabec wrote:
> Hi,
> 
> Dne ponedeljek, 27. november 2017 ob 16:41:24 CET je Maxime Ripard napisal(a):
> > Hi,
> > 
> > Here is an attempt at supporting the LVDS output in our DRM driver. This
> > has been tested on the A83T (with DE2), but since everything is basically
> > in the TCON, it should also be usable on the older SoCs with minor
> > modifications.
> > 
> > This was the occasion to refactor a bunch of things. The most notable ones
> > would be the documentation, and split of the UI layers in the mixer code,
> 
> I'm just about to send my series of patches which would add full support for 
> UI and VI planes (multi planes, HW scaling, all color formats). It would clash 
> with your patches 6, 7 and 8.
> 
> Preview of my work as a single patch can be seen here:
> https://github.com/jernejsk/linux-1/commit/
> 8fdef3b510b567bfe81c87b0c3e73ddcf4f5b711
> 
> How would you like to handle that? Some changes are similar, but I don't see a 
> point rebasing my patches atop of yours.
> 
> Since I'm almost done, I will just send them and we can discuss them then.

Yeah, I had a quick look at it and it doesn't look like it conflicts
too much. I'll have a closer look as soon as I can, but I guess we can
just go in parallel and whoever hits first wins.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/8004aab9/attachment.sig>
