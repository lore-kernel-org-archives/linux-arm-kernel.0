From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 15 Nov 2012 14:43:23 -0800
Subject: [PATCH 7/8] ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
In-Reply-To: <CALLhW=5wiTd9u0PorwDH_68K7XRS8_ajDSDOLB7x8F2qvtJvaA@mail.gmail.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
 <1352830403-1706-8-git-send-email-jon-hunter@ti.com>
 <50A3BE85.5000804@ti.com>
 <CALLhW=5wiTd9u0PorwDH_68K7XRS8_ajDSDOLB7x8F2qvtJvaA@mail.gmail.com>
Message-ID: <20121115224323.GD16377@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 02:42:13PM -0600, Omar Ramirez Luna wrote:
> Hi Jon,
> 
> On 14 November 2012 09:53, Jon Hunter <jon-hunter@ti.com> wrote:
> >> diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
> >> index 3d28b23..6aea6f1 100644
> >> --- a/drivers/staging/tidspbridge/core/ue_deh.c
> >> +++ b/drivers/staging/tidspbridge/core/ue_deh.c
> >> @@ -19,7 +19,6 @@
> >>
> >>  #include <linux/kernel.h>
> >>  #include <linux/interrupt.h>
> >> -#include <plat/dmtimer.h>
> >>
> >>  #include <dspbridge/dbdefs.h>
> >>  #include <dspbridge/dspdeh.h>
> >
> > Hi Omar, I should have had you in copy on this one. Are you ok with the
> > removal of the above dmtimer.h include? It does not appear that this
> > file needs to include dmtimer.h.
> 
> Indeed, we don't use it here.
> 
> > Is it ok for this to go through Tony's tree? If so, care to ACK?
> 
> Looks fine to me, but I believe you will want to let Greg know if this
> patch will bypass staging tree.

That's fine with me for such trivial stuff.

greg k-h
