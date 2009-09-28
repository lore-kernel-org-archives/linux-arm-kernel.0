From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 28 Sep 2009 12:40:00 -0700
Subject: [PATCH] Fix bcmring compile
In-Reply-To: <A6D19A13FE030A409EC4362C172E091F0D5C1F43@eseldmw101.eemea.ericsson.se>
Message-ID: <9383297B60843144AC17878B479520F110AEE53918@SJEXCHCCR01.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at stericsson.com] 
> Sent: September 28, 2009 12:04 PM
> To: Scott Branden; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] Fix bcmring compile
> 
> [Scott]
> 
> > The core.c for bcmring was based on mach-versatile.
> > We missed removing this unused include.  
> > An easy fix - Thanks.
> 
> That's Acked-by: Scott Branden <sbranden@broadcom.com> I 
> presume? (That will make it officially approved by the mach 
> maintainer in my eyes you know...)
> 
Yes, it's:
Acked-by: Scott Branden <sbranden@broadcom.com>

> Linus Walleij
> 
> 
