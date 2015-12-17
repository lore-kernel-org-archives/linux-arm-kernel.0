From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Dec 2015 16:06:03 +0000
Subject: [PATCH v10 0/4] irqchip:support mbigen interrupt controller
In-Reply-To: <1450353397-47668-1-git-send-email-majun258@huawei.com>
References: <1450353397-47668-1-git-send-email-majun258@huawei.com>
Message-ID: <5672DD6B.4080304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/15 11:56, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> This patch set adds the driver of mbigen and binding document for Hisilicon
> Mbigen chips.

[...[

Right, we're almost there. Assuming you quickly deal with the couple of
remarks Mark had, I'll apply this on top of my irq/wire-msi-bridge
branch for Thomas to merge it into 4.5.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
