From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Nov 2014 14:27:27 +0100
Subject: [PATCH v4 11/19] arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
In-Reply-To: <1415959683-26027-12-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-12-git-send-email-andre.przywara@arm.com>
Message-ID: <20141123132727.GX3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:07:55AM +0000, Andre Przywara wrote:
> vgic_set_attr() and vgic_get_attr() contain both code specific for
> the emulated GIC as well as code for the userland facing, generic
> part of the GIC.
> Split the guest GIC facing code of from the generic part to allow
> easier splitting later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
