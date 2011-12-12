From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 12 Dec 2011 23:05:27 +0000
Subject: [PATCH 4/5] MAINTAINERS: add maintainer entry for Picochip
 picoxcell
In-Reply-To: <1323728908.1812.5.camel@joe2Laptop>
References: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
 <1323726414-3319-5-git-send-email-jamie@jamieiles.com>
 <1323728908.1812.5.camel@joe2Laptop>
Message-ID: <20111212230527.GB2616@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 02:28:28PM -0800, Joe Perches wrote:
> On Mon, 2011-12-12 at 21:46 +0000, Jamie Iles wrote:
> > Add maintainer entry for the picoxcell machine support and associated
> > drivers.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -5114,6 +5114,14 @@ L:	linux-mtd at lists.infradead.org
> >  S:	Maintained
> >  F:	drivers/mtd/devices/phram.c
> >  
> > +PICOXCELL SUPPORT
> > +M:	Jamie Iles <jamie@jamieiles.com>
> > +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > +T:	git git://github.com/jamieiles/linux-2.6-ji.git
> > +S:	Supported
> > +F:	arch/arm/mach-picoxcell
> > +F:	drivers/*/picoxcell*
> 
> This wildcard matches only 1 directory depth level.
> 
> To match "drivers/char/hw_random/picoxcell-rng.c"
> you also need to have:
> 
> F:	drivers/*/*/picoxcell*

Thanks Joe, I'll update accordingly.

Jamie
