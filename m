From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 17 Jan 2013 10:09:48 +0100
Subject: [PATCH] ARM: spear3xx: Fix pl080-related build failure
In-Reply-To: <CAOh2x=mnHtqGD17fF8TVU4uX3ceHD8dDRv_k9NwWqk=FDJg=nQ@mail.gmail.com>
References: <1358411351-18506-1-git-send-email-thierry.reding@avionic-design.de>
 <CAOh2x=mnHtqGD17fF8TVU4uX3ceHD8dDRv_k9NwWqk=FDJg=nQ@mail.gmail.com>
Message-ID: <20130117090948.GA21428@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 02:05:58PM +0530, Viresh Kumar wrote:
> On Thu, Jan 17, 2013 at 1:59 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > Include linux/amba/pl08x.h to pull in the various PL080_* macros.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> >  arch/arm/mach-spear3xx/spear3xx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
> > index f9d754f..7c218d9 100644
> > --- a/arch/arm/mach-spear3xx/spear3xx.c
> > +++ b/arch/arm/mach-spear3xx/spear3xx.c
> > @@ -14,6 +14,7 @@
> >  #define pr_fmt(fmt) "SPEAr3xx: " fmt
> >
> >  #include <linux/amba/pl022.h>
> > +#include <linux/amba/pl080.h>
> >  #include <linux/amba/pl08x.h>
> >  #include <linux/io.h>
> >  #include <plat/pl080.h>
> 
> Hi Thierry,
> 
> Thanks for fixing it up. Though the log doesn't match the change well.

Yes, you're right. I've sent an updated patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/1cac57d8/attachment.sig>
