From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 Oct 2017 14:05:12 +0100
Subject: [PATCH v4 02/26] KVM: arm/arm64: vgic: restructure
 kvm_vgic_(un)map_phys_irq
In-Reply-To: <20171025144443.GH91785@lvm> (Christoffer Dall's message of "Wed,
 25 Oct 2017 16:44:43 +0200")
References: <20171006153401.5481-1-marc.zyngier@arm.com>
 <20171006153401.5481-3-marc.zyngier@arm.com>
 <20171025144443.GH91785@lvm>
Message-ID: <86lgjyawl3.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 25 2017 at  4:44:43 pm BST, Christoffer Dall <cdall@linaro.org> wrote:
> On Fri, Oct 06, 2017 at 04:33:37PM +0100, Marc Zyngier wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>> 
>> We want to reuse the core of the map/unmap functions for IRQ
>> forwarding. Let's move the computation of the hwirq in
>> kvm_vgic_map_phys_irq and pass the linux IRQ as parameter.
>> the host_irq is added to struct vgic_irq.
>> 
>> We introduce kvm_vgic_map/unmap_irq which take a struct vgic_irq
>> handle as a parameter.
>> 
>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> Marc,
>   I need a signed-off-by from you on this patch.

Ah, my bad. I'll fix that for the next round (real soon now...)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
