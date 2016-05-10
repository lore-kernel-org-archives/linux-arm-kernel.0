From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 10:05:30 +0100
Subject: [PATCH v3 13/55] KVM: arm/arm64: vgic-new: Add data structure
 definitions
In-Reply-To: <1462531568-9799-14-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-14-git-send-email-andre.przywara@arm.com>
Message-ID: <5731A45A.7040309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Add a new header file for the new and improved GIC implementation.
> The big change is that we now have a struct vgic_irq per IRQ instead
> of spreading all the information over various bitmaps.
> 
> We include this new header conditionally from within the old header
> file for the time being to avoid touching all the users.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
