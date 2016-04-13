From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 13 Apr 2016 15:18:07 +0100
Subject: [PATCH V4 2/7] irqchip, GICv3, ITS: Cleanup for ITS domain
 initialization.
In-Reply-To: <1459759975-24097-3-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-3-git-send-email-tn@semihalf.com>
Message-ID: <570E551F.608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/16 09:52, Tomasz Nowicki wrote:
> There is no point to initialize ITS without having msi-controller
> property in corresponding DT node. However, its_probe is checking
> msi-controller presence at the end, so we can save our time and do that
> check prior to its_probe call. Also, for the code clarity purpose,
> we put domain initialization to separate function.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
