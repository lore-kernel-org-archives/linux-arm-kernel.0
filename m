From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 14:44:11 +0100
Subject: [PATCH v7 24/24] KVM: arm64: vgic-v3:
 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES
In-Reply-To: <1494084283-12723-25-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:43 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-25-git-send-email-eric.auger@redhat.com>
Message-ID: <87k25sixxw.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:43 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> This patch adds a new attribute to GICV3 KVM device
> KVM_DEV_ARM_VGIC_GRP_CTRL group. This allows userspace to
> flush all GICR pending tables into guest RAM.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
