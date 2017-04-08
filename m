From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 08 Apr 2017 11:07:17 +0100
Subject: [PATCH v4 04/22] KVM: arm64: ITS: KVM_DEV_ARM_VGIC_GRP_ITS_REGS
 group
In-Reply-To: <1490607072-21610-5-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Mon, 27 Mar 2017 11:30:54 +0200")
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-5-git-send-email-eric.auger@redhat.com>
Message-ID: <86lgrbciwa.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27 2017 at 10:30:54 AM, Eric Auger <eric.auger@redhat.com> wrote:
> The ITS KVM device exposes a new KVM_DEV_ARM_VGIC_GRP_ITS_REGS
> group which allows the userspace to save/restore ITS registers.
>
> At this stage the get/set/has operations are not yet implemented.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
