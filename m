From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 09:59:43 +0100
Subject: [PATCH v3 10/55] KVM: arm/arm64: Export mmio_read/write_bus
In-Reply-To: <1462531568-9799-11-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-11-git-send-email-andre.przywara@arm.com>
Message-ID: <5731A2FF.5050203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Rename mmio_{read,write}_bus to kvm_mmio_{read,write}_bus and export
> them out of mmio.c.
> This will be needed later for the new VGIC implementation.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
