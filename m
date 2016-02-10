From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 10:25:39 +0000
Subject: [PATCH V3 04/10] irqchip / GICv3: remove gic root node in ITS
In-Reply-To: <1453209083-3358-5-git-send-email-tn@semihalf.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-5-git-send-email-tn@semihalf.com>
Message-ID: <56BB1023.4090005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 13:11, Tomasz Nowicki wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> The gic_root_node defined in ITS driver is not actually
> used, and the ITS driver seems will not use it in the
> future, so just remove it.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
