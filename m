From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 7 Dec 2015 12:41:23 +0000
Subject: [PATCH v5 4/4] MAINTAINERS: Add Liviu Dudau as maintainer for
 ARM HDLCD driver.
In-Reply-To: <56657957.3010202@suse.cz>
References: <1449490265-6752-1-git-send-email-Liviu.Dudau@arm.com>
 <1449490265-6752-5-git-send-email-Liviu.Dudau@arm.com>
 <56657957.3010202@suse.cz>
Message-ID: <20151207124123.GK972@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 01:19:35PM +0100, Jiri Slaby wrote:
> On 12/07/2015, 01:11 PM, Liviu Dudau wrote:
> > Update MAINTAINERS file for HDLCD driver.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Jiri Slaby <jslaby@suse.com>

Hi Jiri,

> 
> Please drop all of us who edited MAINTAINERS in the last decade from
> your CC list in next submissions. Naturally, we do not care about your
> changes in MAINTAINERS at all.

Sorry for the noise, but as you have guess, I've used the list generated
by get_maintainers.pl. Hopefully this is the last iteration of the series,
but if there will be further ones I will make sure that I remove you from
the Cc: list and keep only the commit_signers.

Best regards,
Liviu

> 
> get_maintainers perhaps should not return 'git log' people for the
> MAINTAINERS file?
> 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cba790b..8a637e3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -820,6 +820,12 @@ S:	Maintained
> >  F:	drivers/net/arcnet/
> >  F:	include/uapi/linux/if_arcnet.h
> >  
> > +ARM HDLCD DRM DRIVER
> > +M:	Liviu Dudau <liviu.dudau@arm.com>
> > +S:	Maintained
> > +F:	drivers/gpu/drm/arm/
> > +F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
> > +
> >  ARM MFM AND FLOPPY DRIVERS
> >  M:	Ian Molton <spyro@f2s.com>
> >  S:	Maintained
> > 
> 
> thanks,
> -- 
> js
> suse labs
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
