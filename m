From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Aug 2010 16:34:50 +0300
Subject: ARM Kernel autobuilder
In-Reply-To: <20100723073051.GV31293@n2100.arm.linux.org.uk>
References: <20100722111412.GB10399@kyllikki.org>
	<20100722132400.GR31293@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C6254BEF@dbde02.ent.ti.com>
	<20100723040454.GA30291@verge.net.au>
	<20100723073051.GV31293@n2100.arm.linux.org.uk>
Message-ID: <20100803133449.GD5450@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100723 10:29]:
> On Fri, Jul 23, 2010 at 01:04:54PM +0900, Simon Horman wrote:
> > Are there any other reasons to keep omap_4430sdp_defconfig?
> > SMP seems to be a weak argument to me, after all if I peek in to
> > arch/x86/configs/ I don't see SMP and non-SMP variants.
> 
> SMP is a strong argument on ARM - a SMP kernel can't be booted on
> UP machines, whereas on x86, a SMP kernel can be booted on UP machines.

Late ack from me to stop building other omap defconfigs than
omap3_defconfig and omap_4430sdp_defconfig.

Cheers,

Tony
