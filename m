From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 26 Apr 2018 16:10:44 +0200
Subject: [PATCH 0/3] arm64/kvm spectre-v1 fixes
In-Reply-To: <20180425161342.38133-1-mark.rutland@arm.com>
References: <20180425161342.38133-1-mark.rutland@arm.com>
Message-ID: <20180426141044.GC13249@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 05:13:39PM +0100, Mark Rutland wrote:
> These patches fix arm64-specific potential spectre-v1 gadgets found by
> smatch when run over v4.17-rc2.
> 
> I'm still building up my smatch database, so it's possible that there are
> further gadgets to be found.
> 
> For the moment I've ignored issues which appear to be cross-architecture.
> 
> Thanks,
> Mark.
> 
> Mark Rutland (3):
>   arm64: fix possible spectre-v1 in ptrace_hbp_get_event()
>   KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_get_irq()
>   KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_mmio_read_apr()

For the KVM-related parts:

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
