From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 13:16:03 +0100
Subject: [PATCH v7 15/24] KVM: arm64: vgic-its: Read config and pending
 bit in add_lpi()
In-Reply-To: <1494084283-12723-16-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:34 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-16-git-send-email-eric.auger@redhat.com>
Message-ID: <87shkgkgl8.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:34 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> When creating the lpi we now ask the redistributor what is the state
> of the LPI (priority, enabled, pending).
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
