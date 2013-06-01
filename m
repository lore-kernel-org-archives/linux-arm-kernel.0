From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Jun 2013 22:04:30 +0200
Subject: [PATCH 13/15] [media] omap3isp: include linux/mm_types.h
In-Reply-To: <3507557.BiLMFItQuE@avalon>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-14-git-send-email-arnd@arndb.de>
 <3507557.BiLMFItQuE@avalon>
Message-ID: <201306012204.30778.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 June 2013, Laurent Pinchart wrote:
> > diff --git a/drivers/media/platform/omap3isp/ispqueue.h
> > b/drivers/media/platform/omap3isp/ispqueue.h index 908dfd7..e6e720c 100644
> > --- a/drivers/media/platform/omap3isp/ispqueue.h
> > +++ b/drivers/media/platform/omap3isp/ispqueue.h
> > @@ -31,6 +31,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/videodev2.h>
> >  #include <linux/wait.h>
> > +#include <linux/mm_types.h>
> 
> Could you please make sure the headers are sorted alphabetically ?

I normally do. Sorry for missing it this time.

> Would you like me to take the patch in my tree ? If so I'll sort the headers 
> myself.

Yes, that would be nice, thanks!

	Arnd
