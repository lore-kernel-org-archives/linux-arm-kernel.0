From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:53:00 +0530
Subject: [PATCH v5 05/22] KVM: arm64: vgic-its:
 KVM_DEV_ARM_VGIC_GRP_ITS_REGS group
In-Reply-To: <1492164934-988-6-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-6-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumchKeDYDQY9s0DO2GConjM9M625S1sNQ1aW0VfNuwF1Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> The ITS KVM device exposes a new KVM_DEV_ARM_VGIC_GRP_ITS_REGS
> group which allows the userspace to save/restore ITS registers.
>
> At this stage the get/set/has operations are not yet implemented.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>

Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
