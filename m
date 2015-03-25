From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 17:21:42 +0000
Subject: [PATCH v2 09/12] KVM: arm/arm64: prepare GICv2 emulation to be
 handled by kvm_io_bus
In-Reply-To: <1427126309-11223-10-git-send-email-andre.przywara@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-10-git-send-email-andre.przywara@arm.com>
Message-ID: <5512EEA6.70508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 15:58, Andre Przywara wrote:
> Using the framework provided by the recent vgic.c changes we register
> a kvm_io_bus device when initializing the virtual GICv2.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
