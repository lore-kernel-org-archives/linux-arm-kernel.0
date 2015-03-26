From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 Mar 2015 21:46:20 +0000
Subject: [PATCH v3 08/11] KVM: arm/arm64: prepare GICv2 emulation to be
 handled by kvm_io_bus
In-Reply-To: <1427380778-942-9-git-send-email-andre.przywara@arm.com>
References: <1427380778-942-1-git-send-email-andre.przywara@arm.com>
 <1427380778-942-9-git-send-email-andre.przywara@arm.com>
Message-ID: <20150326214620.35406305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Mar 2015 14:39:35 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

> Using the framework provided by the recent vgic.c changes we register
> a kvm_io_bus device when initializing the virtual GICv2.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
