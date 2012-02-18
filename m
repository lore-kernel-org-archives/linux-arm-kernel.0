From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Feb 2012 23:18:49 +0000
Subject: [PATCH 1/4] ARM: sa1100: fix sa1100 after sparse irq conversion
In-Reply-To: <1329449534-23811-2-git-send-email-robherring2@gmail.com>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
 <1329449534-23811-2-git-send-email-robherring2@gmail.com>
Message-ID: <20120218231849.GA1269@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 09:32:11PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> SA1100 was converted to sparse irq in parallel with include of mach/irqs.h
> being removed from asm/irq.h when sparse irq is enabled, resulting in lots
> of compile errors.

Can this be applied before the change to enable sparse IRQ for sa11x0
platforms without breaking them?

Thanks.
