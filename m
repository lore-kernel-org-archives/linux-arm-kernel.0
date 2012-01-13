From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jan 2012 17:26:27 -0500 (EST)
Subject: [RFC PATCH 01/10] rtc: sa1100: include mach/irqs.h instead of
 asm/irq.h
In-Reply-To: <20120113214540.GF1068@n2100.arm.linux.org.uk>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-2-git-send-email-robherring2@gmail.com>
 <20120113164336.GA1068@n2100.arm.linux.org.uk> <4F106299.8050306@gmail.com>
 <alpine.LFD.2.02.1201131536040.2722@xanadu.home>
 <20120113214540.GF1068@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1201131700520.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jan 2012, Russell King - ARM Linux wrote:

> Why put so much work into a mostly dead platform?  Well, it's one of the
> few decent platforms which I have, which actually has working DMA hardware.
> Why audio?  It's one of those which provides a significant stress test on
> DMA stuff being correct.  Why IrDA?  It can reconfigure a DMA channel (eg,
> burst size) on the fly when it switches between SIR/FIR mode.
> 
> It may be 12 years old but it's still a very useful platform to develop
> non-hardware specific features on!

Absolutely.  Having a simple (by today's standard) platform to develop 
new interfaces is certainly a good way to make sure things work in 
practice, and that provides a nice examples for others to follow.


Nicolas
