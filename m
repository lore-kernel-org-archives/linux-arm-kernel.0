From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 09:50:52 +0000
Subject: [PATCH V3 01/10] irqchip / GICv3: Refactor gic_of_init() for
 GICv3 driver
In-Reply-To: <1453209083-3358-2-git-send-email-tn@semihalf.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-2-git-send-email-tn@semihalf.com>
Message-ID: <56BB07FC.8040609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 13:11, Tomasz Nowicki wrote:
> Isolate hardware abstraction (FDT) code to gic_of_init().
> Rest of the logic goes to gic_init_bases() and expects well
> defined data to initialize GIC properly. The same solution
> is used for GICv2 driver.
> 
> This is needed for ACPI initialization later.
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
