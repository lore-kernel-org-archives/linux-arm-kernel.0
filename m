From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 14:02:31 +0100
Subject: [PATCH v7 17/24] KVM: arm64: vgic-its: vgic_its_alloc_ite/device
In-Reply-To: <1494084283-12723-18-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:36 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-18-git-send-email-eric.auger@redhat.com>
Message-ID: <87h90wkefs.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:36 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> Add two new helpers to allocate an its ite and an its device.
> This will avoid duplication on restore path.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
