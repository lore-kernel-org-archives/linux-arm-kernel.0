From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 10:48:16 +0100
Subject: [PATCH v3 16/55] KVM: arm/arm64: vgic-new: Add IRQ sorting
In-Reply-To: <1462531568-9799-17-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-17-git-send-email-andre.przywara@arm.com>
Message-ID: <5731AE60.40905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Adds the sorting function to cover the case where you have more IRQs
> to consider than you have LRs. We now consider priorities.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
