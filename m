From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:52:09 +0530
Subject: [PATCH v5 04/22] arm/arm64: vgic: turn vgic_find_mmio_region into
 public
In-Reply-To: <1492164934-988-5-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-5-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumfUmRDDXS6+FUg_DBNudJympRorUNVfF_RN5Kt7geOMWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> We plan to use vgic_find_mmio_region in vgic-its.c so let's
> turn it into a public function.
>
> Also let's take the opportunity to rename the region parameter
> into regions to emphasize this latter is an array of regions.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
