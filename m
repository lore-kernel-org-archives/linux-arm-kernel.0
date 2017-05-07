From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 14:14:15 +0100
Subject: [PATCH v7 20/24] KVM: arm64: vgic-its: vgic_its_check_id returns
 the entry's GPA
In-Reply-To: <1494084283-12723-21-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:39 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-21-git-send-email-eric.auger@redhat.com>
Message-ID: <874lwwkdw8.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:39 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> As vgic_its_check_id() computes the device/collection entry's
> GPA, let's return it so that new callers can retrieve it easily.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
