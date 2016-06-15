From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 15 Jun 2016 18:12:08 +0200
Subject: [PATCH v5 3/3] MAINTAINERS: Add entry for Mali-DP driver
In-Reply-To: <20160615153524.GA21140@imgtec.com>
References: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
 <1466002295-24813-4-git-send-email-Liviu.Dudau@arm.com>
 <20160615153524.GA21140@imgtec.com>
Message-ID: <20160615161208.GQ1338@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 04:35:24PM +0100, Eric Engestrom wrote:
> On Wed, Jun 15, 2016 at 03:51:35PM +0100, Liviu Dudau wrote:
> > Add MAINTAINERS entry for ARM Mali-DP driver and update the
> > HDLCD file matching pattern to cover only HDLCD rather than
> > the whole drivers/gpu/drm/arm directory.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > ---
> >  MAINTAINERS | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0bf119c..16deb07 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -865,9 +865,17 @@ F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
> >  ARM HDLCD DRM DRIVER
> >  M:	Liviu Dudau <liviu.dudau@arm.com>
> >  S:	Supported
> > -F:	drivers/gpu/drm/arm/
> > +F:	drivers/gpu/drm/arm/hdlcd_*
> >  F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
> >  
> > +ARM MALI-DP DRM DRIVER
> > +M:	Liviu Dudau <liviu.dudau@arm.com>
> > +M:	Brian Starkey <brian.starkey@arm.com>
> > +M:	Mali DP Maintainers <malidp@foss.arm.com>
> > +S:	Supported
> > +F:	drivers/gpu/drm/arm/
> 
> IIUC this will also catch `drivers/gpu/drm/arm/hdlcd_*`.
> Did you mean `drivers/gpu/drm/arm/malidp_*` ?

Or just merge it and create one entry for all ARM drm drivers?
-Daniel

> 
> > +F:	Documentation/devicetree/bindings/display/arm,malidp.txt
> > +
> >  ARM MFM AND FLOPPY DRIVERS
> >  M:	Ian Molton <spyro@f2s.com>
> >  S:	Maintained
> > -- 
> > 2.8.2

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
