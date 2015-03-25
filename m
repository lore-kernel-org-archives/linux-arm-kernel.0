From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 17:36:54 +0000
Subject: [PATCH v2 12/12] KVM: arm/arm64: remove now obsolete VGIC specific
 MMIO handling code
In-Reply-To: <1427126309-11223-13-git-send-email-andre.przywara@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-13-git-send-email-andre.przywara@arm.com>
Message-ID: <5512F236.10001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 15:58, Andre Przywara wrote:
> With all of the virtual GIC emulation code now being registered with
> the kvm_io_bus, we can remove all of the old MMIO handling code and
> its dispatching functionality.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
