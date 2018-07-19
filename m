From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 18:11:01 +0200
Subject: [PATCH v4 02/10] KVM: arm/arm64: vgic: Keep track of
 implementation revision
In-Reply-To: <1531746387-7033-3-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-3-git-send-email-christoffer.dall@arm.com>
Message-ID: <20180719161101.jitjn46xtlwmzwrd@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:06:19PM +0200, Christoffer Dall wrote:
> As we are about to tweak implementation aspects of the VGIC emulation,
> while still preserving some level of backwards compatibility support,
> add a field to keep track of the implementation revision field which is
> reported to the VM and to userspace.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  include/kvm/arm_vgic.h           | 3 +++
>  virt/kvm/arm/vgic/vgic-init.c    | 1 +
>  virt/kvm/arm/vgic/vgic-mmio-v2.c | 6 ++++--
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 6 ++++--
>  4 files changed, 12 insertions(+), 4 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
