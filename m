From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 11:49:57 +0100
Subject: [PATCH v3 25/55] KVM: arm/arm64: vgic-new: Add PENDING registers
 handlers
In-Reply-To: <1462531568-9799-26-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-26-git-send-email-andre.przywara@arm.com>
Message-ID: <5731BCD5.4040806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> The pending register handlers are shared between the v2 and v3
> emulation, so their implementation goes into vgic-mmio.c, to be easily
> referenced from the v3 emulation as well later.
> For level triggered interrupts the real line level is unaffected by
> this write, so we keep this state separate and combine it with the
> device's level to get the actual pending state.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
