From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 7 Nov 2014 11:40:12 +0100 (CET)
Subject: [Patch Part2 v5 21/31] PCI/MSI: Enhance core to support hierarchy
 irqdomain
In-Reply-To: <1415283644-2559-22-git-send-email-jiang.liu@linux.intel.com>
References: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
 <1415283644-2559-22-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1411071139260.3789@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Nov 2014, Jiang Liu wrote:

> Enhance PCI MSI core to support hierarchy irqdomain, so the common
> code could be shared among architectures.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
> Hi Thomas,
> 	These changes are a temporary solution, I'm working on another
> patch set which will refine these interfaces, especially kill 
> arch_msi_irq_domain_{set|get}_hwirq().

Ok. Please don't forget the irq_chip change :)

Thanks,

	tglx
