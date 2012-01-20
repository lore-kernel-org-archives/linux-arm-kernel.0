From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 20 Jan 2012 16:11:03 -0500 (EST)
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <1327091591-27125-12-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1201201608400.19587@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jan 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
> removed by converting platforms over to sparse irq.
> 
> This intentionally breaks platforms that enable SPARSE_IRQ.

I don't get what you mean here.  The above seems contradictory.


Nicolas
