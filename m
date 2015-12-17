From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Dec 2015 16:02:24 +0000
Subject: [PATCH v10 3/4] irqchip:create irq domain for each mbigen device
In-Reply-To: <1450353397-47668-4-git-send-email-majun258@huawei.com>
References: <1450353397-47668-1-git-send-email-majun258@huawei.com>
 <1450353397-47668-4-git-send-email-majun258@huawei.com>
Message-ID: <5672DC90.2000100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/15 11:56, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> For peripheral devices which connect to mbigen,mbigen is a interrupt
> controller. So, we create irq domain for each mbigen device and add
> mbigen irq domain into irq hierarchy structure.
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
