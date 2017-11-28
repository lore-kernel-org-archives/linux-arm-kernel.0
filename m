From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:43:53 +0100
Subject: [PATCH 12/17] drm/sun4i: Add CCSC property to DE2 configuration
In-Reply-To: <1763fe2cf572135ef030a26a32b907d7@aosc.io>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-13-jernej.skrabec@siol.net>
 <1763fe2cf572135ef030a26a32b907d7@aosc.io>
Message-ID: <20171128204353.imy2rd6fy7hzrvzg@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 08:02:26PM +0800, Icenowy Zheng wrote:
> ? 2017-11-28 04:57?Jernej Skrabec ???
> > Base addresses of channel output CSC (CCSC) depends whether mixer in
> > question is first or second and if it is second, if supports VEP or not.
> > This new property will tell which set of base addresses to take.
> > 
> > 0 - first mixer or second mixer with VEP support
> > 1 - second mixer without VEP support
> 
> Maxime,
> 
> I think here the ID of the mixer matters.
> 
> P.S. I didn't found any SoC with a second mixer with VEP currently

Then we'll have an allwinner,has-vep; property (or whatever) for all
those SoCs' mixer0. What's the big deal about it?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/c61690bf/attachment.sig>
