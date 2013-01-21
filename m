From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 21 Jan 2013 05:27:16 +0000
Subject: [PATCH 1/9] ARM: OMAP2+: AM33XX: CM: Get rid of unncessary
 header inclusions
In-Reply-To: <50F94085.3030704@mvista.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
 <1358493569-17142-2-git-send-email-vaibhav.bedia@ti.com>
 <50F94085.3030704@mvista.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF09DB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 18:01:01, Sergei Shtylyov wrote:
> On 18-01-2013 11:19, Vaibhav Bedia wrote:
> 
> > Some of the included header files are not needed so
> > remove them.
> 
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Change from RFC version:
> > 	No change
> 
> >   arch/arm/mach-omap2/cm33xx.h |    7 +------
> >   1 files changed, 1 insertions(+), 6 deletions(-)
> 
> > diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
> > index 5fa0b62..8009e13 100644
> > --- a/arch/arm/mach-omap2/cm33xx.h
> > +++ b/arch/arm/mach-omap2/cm33xx.h
> > @@ -17,16 +17,11 @@
> >   #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
> >   #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
> >
> > -#include <linux/delay.h>
> > -#include <linux/errno.h>
> > -#include <linux/err.h>
> > -#include <linux/io.h>
> > -
> >   #include "common.h"
> >
> >   #include "cm.h"
> >   #include "cm-regbits-33xx.h"
> > -#include "cm33xx.h"
> > +#include "iomap.h"
> 
>     You don't comment on this addition in the changelog...

Hmm... ok. Will clarify this in the changelog for v2.

Regards,
Vaibhav
