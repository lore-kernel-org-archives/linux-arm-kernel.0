From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 13:49:54 +0200
Subject: [PATCH v4 17/56] KVM: arm/arm64: vgic-new: Add IRQ sorting
In-Reply-To: <1463392481-26583-18-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-18-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518114954.GC3827@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:05AM +0100, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Adds the sorting function to cover the case where you have more IRQs
> to consider than you have LRs. We now consider priorities.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Eric Auger <eric.auger@linaro.org>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
