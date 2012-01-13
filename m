From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jan 2012 18:51:21 -0500 (EST)
Subject: [RFC PATCH 01/10] rtc: sa1100: include mach/irqs.h instead of
 asm/irq.h
In-Reply-To: <4F10BC7B.4040405@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-2-git-send-email-robherring2@gmail.com>
 <20120113164336.GA1068@n2100.arm.linux.org.uk> <4F106299.8050306@gmail.com>
 <alpine.LFD.2.02.1201131536040.2722@xanadu.home> <4F10BC7B.4040405@gmail.com>
Message-ID: <alpine.LFD.2.02.1201131847560.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jan 2012, Rob Herring wrote:

> On 01/13/2012 02:46 PM, Nicolas Pitre wrote:
> > Another problem that resources solve (and your original patch didn't 
> > make it any better nor worse) has to do with include file search paths.  
> > Once we start building more than one SOC in the kernel, we won't be able 
> > to support the inclusion of <mach/whatever.h> from driver code anymore 
> > since this could refer to more than one instances of 
> > arch/arm/mach-*/include/mach/whatever.h.
> 
> I'm fully aware of this issue and was not trying to solve that here.

I know you are aware (maybe I should have mentioned it explicitly).
This comment was more for the wider audience.


Nicolas
