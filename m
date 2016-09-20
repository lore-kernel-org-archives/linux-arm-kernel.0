From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Sep 2016 12:58:13 +0100
Subject: [PATCH] irqchip, gicv3: Fix out-of-range cpumask access reported
 by cpumask_check()
In-Reply-To: <20160920113858.GA5140@leverpostej>
References: <1474371259-18783-1-git-send-email-rrichter@cavium.com>
 <20160920113858.GA5140@leverpostej>
Message-ID: <57E12455.8000507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/16 12:39, Mark Rutland wrote:
> On Tue, Sep 20, 2016 at 01:34:19PM +0200, Robert Richter wrote:
>> Booting a kernel with DEBUG_PER_CPU_MAPS enabled triggers the follwing
>> warning:
>>
>>  WARNING: CPU: 1 PID: 0 at ./include/linux/cpumask.h:121 gic_raise_softirq+0x298/0x308
> 
> James posted a patch for this [1], which we were hoping Thomas would
> pick up [2].

It is already in tip/irq/urgent (727653d).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
