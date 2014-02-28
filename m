From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 28 Feb 2014 14:45:56 +0000
Subject: [PATCH v6 07/14] ARM: Remove use of struct kprobe from generic
 probes code
In-Reply-To: <1393596692.3601.37.camel@linaro1.home>
References: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
 <1392017945-4507-8-git-send-email-dave.long@linaro.org>
 <20140228101226.GO21483@n2100.arm.linux.org.uk>
 <1393596692.3601.37.camel@linaro1.home>
Message-ID: <1393598756.3601.44.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-28 at 14:11 +0000, Jon Medhurst (Tixy) wrote:
> On Fri, 2014-02-28 at 10:12 +0000, Russell King - ARM Linux wrote:
> > On Mon, Feb 10, 2014 at 02:38:58AM -0500, David Long wrote:
> > > diff --git a/arch/arm/kernel/probes.c b/arch/arm/kernel/probes.c
> > > index 7cd1763..179deac 100644
> > > --- a/arch/arm/kernel/probes.c
> > > +++ b/arch/arm/kernel/probes.c
> > > @@ -12,11 +12,9 @@
> > >   */
> > >  
> > >  #include <linux/kernel.h>
> > > -#include <linux/kprobes.h>
> > >  #include <asm/system_info.h>
> > 
> > How well has this code been tested?
> 
> From the error below I assume only when __LINUX_ARM_ARCH__ >= 7
> 
> I have v5 and v6 hardware

Actually, I don't have any v6 hardware, for some strange reason I
thought a cortex A8 was v6.

-- 
Tixy
