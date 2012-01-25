From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 25 Jan 2012 17:32:18 -0500 (EST)
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <20120125213206.GJ1068@n2100.arm.linux.org.uk>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1201201608400.19587@xanadu.home> <4F19DB35.9060707@gmail.com>
 <20120125213206.GJ1068@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1201251727510.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jan 2012, Russell King - ARM Linux wrote:

> As a side-note, you may be pleased to know that I have SA11x0 stuff
> converted to (and tested) with sparse IRQ.  That's with SA1111, the
> UCB1x00 and Neponset expansion board for the Assabet all dynamically
> allocating their IRQs.  The only fixed-numbered IRQs in SA11x0 in my
> tree at the time of writing are the on-SoC IRQs, and the LoCoMo IRQs
> (which I don't have the hardware to test for, so I'm not touching.)

That's really cool.

Not that there are many people who might still benefit from running that 
code, but like I said this should serve as a real and relatively simple 
example that might benefit more complex platforms.


Nicolas
