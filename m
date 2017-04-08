From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 08 Apr 2017 11:06:22 +0100
Subject: [PATCH v4 03/22] arm/arm64: vgic: turn vgic_find_mmio_region into
 public
In-Reply-To: <1490607072-21610-4-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Mon, 27 Mar 2017 11:30:53 +0200")
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-4-git-send-email-eric.auger@redhat.com>
Message-ID: <86pogncixt.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27 2017 at 10:30:53 AM, Eric Auger <eric.auger@redhat.com> wrote:
> We plan to use vgic_find_mmio_region in vgic-its.c so let's
> turn it into a public function.
>
> Also let's take the opportunity to rename the region parameter
> into regions to emphasize this latter is an array of regions.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
