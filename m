From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Dec 2017 09:37:49 +0100
Subject: [PATCH v4 00/15] drm/sun4i: Add A83t LVDS support
In-Reply-To: <20171214070157.rqx4tfpluzaqmtxu@plaes.org>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
 <20171214070157.rqx4tfpluzaqmtxu@plaes.org>
Message-ID: <20171214083749.cy72egte7lru24nb@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 07:01:57AM +0000, Priit Laes wrote:
> On Thu, Dec 07, 2017 at 04:58:45PM +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > Here is an attempt at supporting the LVDS output in our DRM driver. This
> > has been tested on the A83T (with DE2), but since everything is basically
> > in the TCON, it should also be usable on the older SoCs with minor
> > modifications.
> 
> I managed to get the single-channel LVDS working on an A10 tablet after
> doing those minor modifications (although, the colours are off a bit).
> So in general this series looks good :)

Is that a Tested-by? :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/8299378d/attachment.sig>
