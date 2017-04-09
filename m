From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 09 Apr 2017 11:13:57 +0100
Subject: [PATCH v4 14/22] KVM: arm64: ITS: vgic_its_alloc_ite/device
In-Reply-To: <1490607072-21610-15-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Mon, 27 Mar 2017 11:31:04 +0200")
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-15-git-send-email-eric.auger@redhat.com>
Message-ID: <86d1clc2hm.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27 2017 at 10:31:04 AM, Eric Auger <eric.auger@redhat.com> wrote:
> Add two new helpers to allocate an its ite and an its device.
> This will avoid duplication on restore path.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
