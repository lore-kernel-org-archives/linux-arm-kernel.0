From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 18 Nov 2012 23:00:28 +0400
Subject: [PATCH] Dove: Fix irq_to_pmu()
In-Reply-To: <20121118163932.GW3290@n2100.arm.linux.org.uk>
References: <20121118162944.GV3290@n2100.arm.linux.org.uk>
 <20121118163932.GW3290@n2100.arm.linux.org.uk>
Message-ID: <50A9304C.9010006@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-11-2012 20:39, Russell King - ARM Linux wrote:

> PMU interrupts start at IRQ_DOVE_PMU_START, not IRQ_DOVE_PMU_START + 1.
> Fix the condition.  (It may have been less likely to occur had the code
> been written "if (irq >= IRQ_DOVE_PMU_START" which imho is the easier
> to understand notation, and matches the normal way of thinking about
> these things.)

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --

    Should be "---", or somebody (you?) will have to hand edit the patch when 
applying...

WBR, Sergei
