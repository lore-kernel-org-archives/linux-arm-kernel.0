From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Feb 2014 16:24:15 +0800
Subject: [PATCH 2/4] ARM: imx6: build headsmp.o only on CONFIG_SMP
In-Reply-To: <20140226210056.GB21483@n2100.arm.linux.org.uk>
References: <1393422280-22283-1-git-send-email-shawn.guo@linaro.org>
 <1393422280-22283-2-git-send-email-shawn.guo@linaro.org>
 <20140226210056.GB21483@n2100.arm.linux.org.uk>
Message-ID: <20140227082413.GC13537@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 09:00:57PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 26, 2014 at 09:44:38PM +0800, Shawn Guo wrote:
> > diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> > index e4b9fed..6e1a56d 100644
> > --- a/arch/arm/mach-imx/headsmp.S
> > +++ b/arch/arm/mach-imx/headsmp.S
> > @@ -15,7 +15,6 @@
> >  
> >  	.section ".text.head", "ax"
> 
> While you're here, can you please fix the above section name.  I think
> a .text will do just fine here.

Indeed.  I will post a patch for it shortly.

Shawn
