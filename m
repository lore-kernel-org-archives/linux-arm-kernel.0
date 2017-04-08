From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 08 Apr 2017 11:09:29 +0100
Subject: [PATCH v4 05/22] KVM: arm/arm64: vgic: expose (un)lock_all_vcpus
In-Reply-To: <1490607072-21610-6-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Mon, 27 Mar 2017 11:30:55 +0200")
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-6-git-send-email-eric.auger@redhat.com>
Message-ID: <86h91zcism.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27 2017 at 10:30:55 AM, Eric Auger <eric.auger@redhat.com> wrote:
> We need to use those helpers in vgic-its.c so let's
> expose them in the private vgic header.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
