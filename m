From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 16 Aug 2018 09:41:23 +0200
Subject: [PATCH v1 1/7] atmel-hlcdc: renamed directory to drm/atmel/
In-Reply-To: <20180814161952.GA27951@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-1-sam@ravnborg.org>
 <20180814083913.GD21634@phenom.ffwll.local>
 <20180814161952.GA27951@ravnborg.org>
Message-ID: <20180816074123.GB21634@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 06:19:52PM +0200, Sam Ravnborg wrote:
> Hi Daniel.
> 
> > >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c (100%)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 96e98e206b0d..09ce76a9a1dc 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4681,7 +4681,7 @@ DRM DRIVERS FOR ATMEL HLCDC
> > >  M:	Boris Brezillon <boris.brezillon@bootlin.com>
> > >  L:	dri-devel at lists.freedesktop.org
> > >  S:	Supported
> > > -F:	drivers/gpu/drm/atmel-hlcdc/
> > > +F:	drivers/gpu/drm/atmel/atmel-hlcdc*
> > 
> > I'd strongly suggest you group-maintain the entire atmel stuff in
> > drm-misc instead of only atmel-hlcdc.
> 
> If OK with Boris then I am fine with this too.
> Will suggest so in v2.

Boris acked too, but he's on vacation. He said on irc he'll review the
patches when he's back. Meanwhile I guess you can prep by getting the fd.o
account requested:

https://www.freedesktop.org/wiki/AccountRequests/

And checking out the tooling we use to maintain drm-misc:

https://dri.freedesktop.org/docs/dim/getting-started.html

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
