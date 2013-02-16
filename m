From: Barry.Song@csr.com (Barry Song)
Date: Sat, 16 Feb 2013 02:09:46 +0000
Subject: [PATCH 2/3] ARM: prima2: Replace include linux/module.h with
 linux/export.h
In-Reply-To: <CAFBvHifN+oZBGwzHv5PxSZea1O1HTwKwiFa8T3udw5vvRuiMug@mail.gmail.com>
References: <1352821789-6640-1-git-send-email-s.syam@samsung.com>
 <5EB3BFCD089AD643B9BB63439F5FD5E9012296E17C@SHAASIEXM01.ASIA.ROOT.PRI>
 <CAFBvHifN+oZBGwzHv5PxSZea1O1HTwKwiFa8T3udw5vvRuiMug@mail.gmail.com>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E90122CA137F@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Syam,

> -----Original Message-----
> From: Syam Sidhardhan [mailto:syamsidhardh at gmail.com]
> Sent: Friday, February 15, 2013 4:51 AM
> To: Barry Song
> Cc: linux-arm-kernel at lists.infradead.org; DL-SHA-WorkGroupLinux
> Subject: Re: [PATCH 2/3] ARM: prima2: Replace include linux/module.h with
> linux/export.h
> 
> Hi,
> 
> On Wed, Nov 14, 2012 at 8:29 AM, Barry Song <Barry.Song@csr.com> wrote:
> >> -----Original Message-----
> >> From: Syam Sidhardhan [mailto:syamsidhardh at gmail.com]
> >> Sent: Tuesday, November 13, 2012 11:50 PM
> >> To: linux-arm-kernel at lists.infradead.org
> >> Cc: Barry Song
> >> Subject: [PATCH 2/3] ARM: prima2: Replace include linux/module.h with
> >> linux/export.h
> >>
> >> include <linux/export.h> is the right to go here.
> >>
> >> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> >
> > Acked. Thanks!
> >> ---
> >>  arch/arm/mach-prima2/pm.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
> >> index fb5a791..f4a2270 100644
> >> --- a/arch/arm/mach-prima2/pm.c
> >> +++ b/arch/arm/mach-prima2/pm.c
> >> @@ -9,7 +9,7 @@
> >>  #include <linux/kernel.h>
> >>  #include <linux/suspend.h>
> >>  #include <linux/slab.h>
> >> -#include <linux/module.h>
> >> +#include <linux/export.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_address.h>
> >>  #include <linux/of_device.h>
> 
> 
> Ping,..
> It's look like this patch is not yet applied.

I'll handle it together with some other fixes. Thanks!

> 
> Regards,
> Syam

-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
