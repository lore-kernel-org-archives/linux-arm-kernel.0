From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Aug 2015 15:21:40 +0100
Subject: [PATCH 0/6] irqchip: GICv2/v3: Add support for irq_vcpu_affinity
In-Reply-To: <55C9C939.2020408@linaro.org>
References: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
 <55C9C939.2020408@linaro.org>
Message-ID: <55CB5674.2080209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/15 11:06, Eric Auger wrote:
> Hi Marc,
> 
> The series works fine with KVM platform device passthrough use case
> (Calxeda Midway, GICv2, SPI assignment with VFIO). My integration branch
> can be found at
> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.2-rc6-irq-forward-v3
> if useful.
> 
> Tested-by: Eric Auger <eric.auger@linaro.org>

Many thanks for trying it (and for the review). I'll post an updated
version soon.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
